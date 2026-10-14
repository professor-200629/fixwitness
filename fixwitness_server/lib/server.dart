import 'dart:io';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/cache_busting.dart';
import 'src/fixwitness/dev_mailbox.dart';
import 'src/generated/serverpod.dart';
import 'src/web/precompressed.dart';
import 'src/web/routes/app_config_route.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod. The generated Serverpod class is already connected
  // with your project's generated code.
  final pod = Serverpod(args);

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Staging and production send verification codes through the Serverpod
      // Cloud email service. Development writes them to a local dev mailbox
      // file (and the log) so scripted end-to-end runs can sign up accounts.
      if (pod.runMode == ServerpodRunMode.development)
        EmailIdpConfigFromPasswords(
          sendRegistrationVerificationCode: devMailbox.registration,
          sendPasswordResetVerificationCode: devMailbox.passwordReset,
        )
      else
        ServerpodCloudEmailIdpConfig(appDisplayName: 'FixWitness'),
    ],
  );

  // Serve all files in the web/static relative directory under /web.
  // These are used by the default web page.
  pod.webServer.addRoute(
    StaticRoute.withCacheBusting(cacheBustingConfig),
    cacheBustingConfig.mountPrefix,
  );

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Gzipped copies of the bundle (tool/precompress_web.dart) for browsers
    // that accept them: about a third of the bytes on a phone connection.
    pod.webServer.addMiddleware(precompressedStatic(appDir), '/');
    // Serve the flutter web app under /.
    pod.webServer.addRoute(
      FlutterRoute(
        appDir,
        // If building the Flutter app with WASM, set the below parameter to
        // true and add the --wasm flag to the flutter build command.
        enableWasmHeaders: false,
      ),
      '/',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    final defaultRoute = StaticRoute.file(
      File(
        Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
      ),
    );

    pod.webServer.addMiddleware(
      FallbackMiddleware(
        fallback: defaultRoute,
        on: (response) => response.statusCode == 404,
      ).call,
      '/',
    );

    pod.webServer.addRoute(
      defaultRoute,
      '/**',
    );
  }

  // Configure cloud storage.
  // This setup works with Serverpod Cloud without extra configuration.
  // If you want to use a custom provider for cloud storage, replace these
  // with your preferred provider.
  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );
  pod.addCloudStorage(
    await ServerpodCloudProvider.public(
      fallback: () => DatabaseCloudStorage('public'),
    ),
  );

  // Start the server.
  await pod.start();

  // Every hour, delete photo bytes that were uploaded but never registered as
  // evidence (see lib/src/fixwitness/maintenance.dart). Re-registered on each
  // start under a fixed identifier, so restarts do not stack schedules.
  // Future calls need the database and `futureCall.enabled`; where a host
  // switches them off, the server runs without the sweep instead of exiting.
  if (pod.config.database == null || !pod.config.futureCall.enabled) {
    stderr.writeln(
      'Future calls are disabled here: the orphan-upload sweep is not scheduled.',
    );
    return;
  }
  try {
    await pod.futureCalls.cancel('orphan-upload-sweep');
  } catch (_) {
    // Nothing scheduled yet.
  }
  await pod.futureCalls
      .callRecurring(identifier: 'orphan-upload-sweep')
      .every(const Duration(hours: 1))
      .maintenance
      .sweep();
}
