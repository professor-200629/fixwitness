/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:fixwitness_client/src/protocol/condition_item.dart'
    as _i0gfe87e;
import 'package:fixwitness_client/src/protocol/condition_report.dart'
    as _imbyy1qm;
import 'package:fixwitness_client/src/protocol/created_link.dart' as _iejfv6q5;
import 'package:fixwitness_client/src/protocol/customer_job_view.dart'
    as _il7arbhv;
import 'package:fixwitness_client/src/protocol/customer_link.dart' as _ig6niqel;
import 'package:fixwitness_client/src/protocol/estimate.dart' as _iock0gnm;
import 'package:fixwitness_client/src/protocol/estimate_decision.dart'
    as _iz17rufh;
import 'package:fixwitness_client/src/protocol/estimate_line.dart' as _io8rligr;
import 'package:fixwitness_client/src/protocol/evidence_photo.dart'
    as _i8bjtbhl;
import 'package:fixwitness_client/src/protocol/job_detail.dart' as _i41u8z5d;
import 'package:fixwitness_client/src/protocol/job_note.dart' as _itpzkpuz;
import 'package:fixwitness_client/src/protocol/job_summary.dart' as _idiw8vex;
import 'package:fixwitness_client/src/protocol/new_job_input.dart' as _iz0lu8m8;
import 'package:fixwitness_client/src/protocol/photo_stage.dart' as _i8zl8ci1;
import 'package:fixwitness_client/src/protocol/photo_upload_ticket.dart'
    as _ipedemfu;
import 'package:fixwitness_client/src/protocol/repair_job.dart' as _ieb8wg3a;
import 'package:fixwitness_client/src/protocol/shop_context.dart' as _i2vlmjsu;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;
import 'protocol.dart' as _il2as5qe;
import 'package:fixwitness_client/migrations/migration_registry.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// The customer side, reached only with a review-link token. No account is
/// needed; the token grants access to exactly one job.
///
/// Decisions are refused when the request carries a signed-in shop session,
/// and no shop endpoint can record a customer decision.
/// {@category Endpoint}
class EndpointCustomer extends _isc.EndpointRef {
  EndpointCustomer(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customer';

  _ida.Future<_il7arbhv.CustomerJobView> view(String token) =>
      caller.callServerEndpoint<_il7arbhv.CustomerJobView>(
        'customer',
        'view',
        {'token': token},
      );

  /// Approves exactly [versionNumber] of the estimate whose content hash the
  /// customer saw. Refused if a newer version exists or the content differs.
  _ida.Future<_iz17rufh.EstimateDecision> approve(
    String token,
    int estimateId,
    int versionNumber,
    String contentHash,
    String typedName,
  ) => caller.callServerEndpoint<_iz17rufh.EstimateDecision>(
    'customer',
    'approve',
    {
      'token': token,
      'estimateId': estimateId,
      'versionNumber': versionNumber,
      'contentHash': contentHash,
      'typedName': typedName,
    },
  );

  _ida.Future<_iz17rufh.EstimateDecision> decline(
    String token,
    int estimateId,
    int versionNumber,
    String contentHash,
    String typedName,
    String? reason,
  ) => caller.callServerEndpoint<_iz17rufh.EstimateDecision>(
    'customer',
    'decline',
    {
      'token': token,
      'estimateId': estimateId,
      'versionNumber': versionNumber,
      'contentHash': contentHash,
      'typedName': typedName,
      'reason': reason,
    },
  );

  /// Confirms that the customer has their device back.
  _ida.Future<void> acknowledgeCollection(
    String token,
    String typedName,
  ) => caller.callServerEndpoint<void>(
    'customer',
    'acknowledgeCollection',
    {
      'token': token,
      'typedName': typedName,
    },
  );
}

/// Condition and progress photos. Upload is two steps so a device can recover
/// from either half failing:
///
/// 1. [preparePhotoUpload] returns an upload description, or `alreadyStored`
///    when the bytes from an earlier attempt are already on the server.
/// 2. [registerPhoto] checks the stored bytes (type, size, SHA-256) and writes
///    the metadata. It is idempotent per operation id.
/// {@category Endpoint}
class EndpointEvidence extends _isc.EndpointRef {
  EndpointEvidence(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'evidence';

  _ida.Future<_ipedemfu.PhotoUploadTicket> preparePhotoUpload(
    int jobId,
    _isc.UuidValue opId,
    String contentType,
    int sizeBytes,
  ) => caller.callServerEndpoint<_ipedemfu.PhotoUploadTicket>(
    'evidence',
    'preparePhotoUpload',
    {
      'jobId': jobId,
      'opId': opId,
      'contentType': contentType,
      'sizeBytes': sizeBytes,
    },
  );

  _ida.Future<_i8bjtbhl.EvidencePhoto> registerPhoto(
    int jobId,
    _isc.UuidValue opId,
    String contentType,
    String sha256Hex,
    _i8zl8ci1.PhotoStage stage,
    String? caption,
    DateTime capturedAt,
  ) => caller.callServerEndpoint<_i8bjtbhl.EvidencePhoto>(
    'evidence',
    'registerPhoto',
    {
      'jobId': jobId,
      'opId': opId,
      'contentType': contentType,
      'sha256Hex': sha256Hex,
      'stage': stage,
      'caption': caption,
      'capturedAt': capturedAt,
    },
  );

  /// A short-lived URL for one photo of a job in the caller's shop.
  _ida.Future<String> photoUrl(int photoId) =>
      caller.callServerEndpoint<String>(
        'evidence',
        'photoUrl',
        {'photoId': photoId},
      );
}

/// Shop-side job workflow. Every mutation locks the job row, validates the
/// transition, writes the change and its history event in one transaction.
///
/// Methods that a technician may queue offline (create, note, condition)
/// take an operation id and are idempotent: a retry returns the first result.
/// {@category Endpoint}
class EndpointJobs extends _isc.EndpointRef {
  EndpointJobs(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jobs';

  _ida.Future<List<_idiw8vex.JobSummary>> list() =>
      caller.callServerEndpoint<List<_idiw8vex.JobSummary>>(
        'jobs',
        'list',
        {},
      );

  _ida.Future<_i41u8z5d.JobDetail> get(int jobId) =>
      caller.callServerEndpoint<_i41u8z5d.JobDetail>(
        'jobs',
        'get',
        {'jobId': jobId},
      );

  /// Creates a job. [opId] is generated on the device when the technician
  /// starts the intake, so a retried or replayed request returns the same job.
  _ida.Future<_ieb8wg3a.RepairJob> create(
    _isc.UuidValue opId,
    _iz0lu8m8.NewJobInput input,
  ) => caller.callServerEndpoint<_ieb8wg3a.RepairJob>(
    'jobs',
    'create',
    {
      'opId': opId,
      'input': input,
    },
  );

  _ida.Future<_itpzkpuz.JobNote> addNote(
    int jobId,
    _isc.UuidValue opId,
    String text,
    bool customerVisible,
    DateTime writtenAt,
  ) => caller.callServerEndpoint<_itpzkpuz.JobNote>(
    'jobs',
    'addNote',
    {
      'jobId': jobId,
      'opId': opId,
      'text': text,
      'customerVisible': customerVisible,
      'writtenAt': writtenAt,
    },
  );

  _ida.Future<_imbyy1qm.ConditionReport> saveCondition(
    int jobId,
    _isc.UuidValue opId,
    List<_i0gfe87e.ConditionItem> items,
    DateTime capturedAt,
  ) => caller.callServerEndpoint<_imbyy1qm.ConditionReport>(
    'jobs',
    'saveCondition',
    {
      'jobId': jobId,
      'opId': opId,
      'items': items,
      'capturedAt': capturedAt,
    },
  );

  /// Issues a new estimate version. [basedOnVersion] is the latest version the
  /// technician was looking at (null for the first); if someone else issued a
  /// version meanwhile the call is rejected instead of silently stacking.
  _ida.Future<_iock0gnm.Estimate> issueEstimate(
    int jobId,
    int? basedOnVersion,
    List<_io8rligr.EstimateLine> lines,
    String? note,
    String? reasonForRevision,
  ) => caller.callServerEndpoint<_iock0gnm.Estimate>(
    'jobs',
    'issueEstimate',
    {
      'jobId': jobId,
      'basedOnVersion': basedOnVersion,
      'lines': lines,
      'note': note,
      'reasonForRevision': reasonForRevision,
    },
  );

  _ida.Future<_ieb8wg3a.RepairJob> startWork(int jobId) =>
      caller.callServerEndpoint<_ieb8wg3a.RepairJob>(
        'jobs',
        'startWork',
        {'jobId': jobId},
      );

  _ida.Future<_ieb8wg3a.RepairJob> completeRepair(int jobId) =>
      caller.callServerEndpoint<_ieb8wg3a.RepairJob>(
        'jobs',
        'completeRepair',
        {'jobId': jobId},
      );

  /// Records a handover at the counter when the customer cannot confirm on
  /// their own link. History marks it as recorded by shop staff.
  _ida.Future<_ieb8wg3a.RepairJob> recordCollection(
    int jobId,
    String collectedBy,
  ) => caller.callServerEndpoint<_ieb8wg3a.RepairJob>(
    'jobs',
    'recordCollection',
    {
      'jobId': jobId,
      'collectedBy': collectedBy,
    },
  );
}

/// Shop staff create and revoke customer review links.
/// {@category Endpoint}
class EndpointLinks extends _isc.EndpointRef {
  EndpointLinks(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'links';

  /// Creates a link valid for [validDays] (1-30). The returned URL is the only
  /// time the token is visible; the server keeps just its hash.
  _ida.Future<_iejfv6q5.CreatedLink> create(
    int jobId,
    int validDays,
  ) => caller.callServerEndpoint<_iejfv6q5.CreatedLink>(
    'links',
    'create',
    {
      'jobId': jobId,
      'validDays': validDays,
    },
  );

  _ida.Future<_ig6niqel.CustomerLink> revoke(int linkId) =>
      caller.callServerEndpoint<_ig6niqel.CustomerLink>(
        'links',
        'revoke',
        {'linkId': linkId},
      );
}

/// Shop membership for the signed-in user.
/// {@category Endpoint}
class EndpointShop extends _isc.EndpointRef {
  EndpointShop(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'shop';

  /// The caller's shop and role, or null if they have not created a shop yet.
  _ida.Future<_i2vlmjsu.ShopContext?> myShop() =>
      caller.callServerEndpoint<_i2vlmjsu.ShopContext?>(
        'shop',
        'myShop',
        {},
      );

  /// Creates a shop owned by the caller. Calling it again returns the existing
  /// shop, so a retried request does not create a second one.
  _ida.Future<_i2vlmjsu.ShopContext> createShop(
    String shopName,
    String yourName,
  ) => caller.callServerEndpoint<_i2vlmjsu.ShopContext>(
    'shop',
    'createShop',
    {
      'shopName': shopName,
      'yourName': yourName,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    customer = EndpointCustomer(this);
    evidence = EndpointEvidence(this);
    jobs = EndpointJobs(this);
    links = EndpointLinks(this);
    shop = EndpointShop(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointCustomer customer;

  late final EndpointEvidence evidence;

  late final EndpointJobs jobs;

  late final EndpointLinks links;

  late final EndpointShop shop;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'customer': customer,
    'evidence': evidence,
    'jobs': jobs,
    'links': links,
    'shop': shop,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };

  /// Creates a new client-side database session for the given path.
  ///
  /// The [path] is the file path to the SQLite database file. Since SQLite uses
  /// WAL mode, note that `[path]-shm` and `[path]-wal` files might also exist
  /// transiently for the database while the session is open.
  ///
  /// If [runMigrations] is true, pending migrations will be applied when
  /// opening the database. Be careful when setting this to false, as it might
  /// lead to inconsistencies between the models and the database.
  ///
  /// If [isDebugMode] is true, the database integrity will be verified after
  /// the migrations are applied to provide feedback of possible issues. On a
  /// Flutter application, this should be set to [kDebugMode].
  _ida.Future<_isd.ClientDatabaseSession> createSession(
    String path, {
    bool runMigrations = true,
    bool isDebugMode = false,
  }) async {
    return await _isd.ClientDatabaseSession.open(
      path,
      _il2as5qe.Protocol(),
      clientMigrations: MigrationRegistry.migrations,
      runMigrations: runMigrations,
      isDebugMode: isDebugMode,
    );
  }
}
