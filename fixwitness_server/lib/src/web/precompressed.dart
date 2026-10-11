import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

/// File types worth compressing. HTML is left to [FlutterRoute], which also
/// handles the single-page-app fallback.
const _types = <String, MimeType>{
  '.js': MimeType.javascript,
  '.mjs': MimeType.javascript,
  '.json': MimeType.json,
  '.css': MimeType.css,
  '.wasm': MimeType('application', 'wasm'),
  '.ttf': MimeType('font', 'ttf'),
  '.otf': MimeType('font', 'otf'),
  '.svg': MimeType('image', 'svg+xml'),
};

/// Serves `<file>.gz` (written by `tool/precompress_web.dart` after a Flutter
/// web build) instead of `<file>` when the browser accepts gzip. Everything
/// else falls through to the next handler unchanged.
///
/// The Flutter web bundle shrinks to roughly a third, which matters when a
/// customer opens their link on mobile data.
Handler Function(Handler) precompressedStatic(Directory root) {
  final rootPath = p.normalize(root.absolute.path);
  final cache = <String, ({DateTime modified, Uint8List bytes, String etag})>{};

  return (Handler next) => (Request request) async {
    if (request.method != Method.get && request.method != Method.head) {
      return next(request);
    }
    final accepts = (request.headers['accept-encoding'] ?? const <String>[])
        .join(',')
        .toLowerCase();
    if (!accepts.contains('gzip')) return next(request);

    final urlPath = Uri.decodeComponent(request.url.path);
    final type = _types[p.extension(urlPath).toLowerCase()];
    if (type == null) return next(request);
    final file = p.normalize(
      p.join(rootPath, urlPath.replaceFirst(RegExp('^/+'), '')),
    );
    if (!p.isWithin(rootPath, file)) return next(request);
    final gz = File('$file.gz');
    if (!await gz.exists()) return next(request);

    final modified = await gz.lastModified();
    var entry = cache[gz.path];
    if (entry == null || entry.modified != modified) {
      final bytes = await gz.readAsBytes();
      entry = (
        modified: modified,
        bytes: bytes,
        etag: '"gz-${sha1.convert(bytes)}"',
      );
      cache[gz.path] = entry;
    }

    // Same caching policy as FlutterRoute: always revalidate, so a redeploy
    // shows up on the next load; unchanged files answer 304 with no body.
    final headers = Headers.fromMap({
      'cache-control': ['no-cache, private'],
      'etag': [entry.etag],
      'vary': ['Accept-Encoding'],
    });
    final ifNoneMatch = (request.headers['if-none-match'] ?? const <String>[])
        .join(',');
    if (ifNoneMatch.contains(entry.etag)) {
      return Response.notModified(headers: headers);
    }
    return Response.ok(
      body: Body.fromData(entry.bytes, mimeType: type),
      headers: headers.transform((h) => h['content-encoding'] = ['gzip']),
    );
  };
}
