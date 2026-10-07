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
import 'package:fixwitness_server/src/generated/condition_item.dart'
    as _it1p0zjf;
import 'package:fixwitness_server/src/generated/estimate_line.dart'
    as _ixftu19y;
import 'package:fixwitness_server/src/generated/new_job_input.dart'
    as _iau16sri;
import 'package:fixwitness_server/src/generated/photo_stage.dart' as _ipjl1w58;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/customer_endpoint.dart' as _irj2k3gq;
import '../endpoints/evidence_endpoint.dart' as _i2cvsm7u;
import '../endpoints/jobs_endpoint.dart' as _iu8dkase;
import '../endpoints/links_endpoint.dart' as _ix0wsr6z;
import '../endpoints/shop_endpoint.dart' as _i4fqeydl;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'customer': _irj2k3gq.CustomerEndpoint()
        ..initialize(
          server,
          'customer',
          null,
        ),
      'evidence': _i2cvsm7u.EvidenceEndpoint()
        ..initialize(
          server,
          'evidence',
          null,
        ),
      'jobs': _iu8dkase.JobsEndpoint()
        ..initialize(
          server,
          'jobs',
          null,
        ),
      'links': _ix0wsr6z.LinksEndpoint()
        ..initialize(
          server,
          'links',
          null,
        ),
      'shop': _i4fqeydl.ShopEndpoint()
        ..initialize(
          server,
          'shop',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['customer'] = _is.EndpointConnector(
      name: 'customer',
      endpoint: endpoints['customer']!,
      methodConnectors: {
        'view': _is.MethodConnector(
          name: 'view',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _irj2k3gq.CustomerEndpoint).view(
                    session,
                    params['token'],
                  ),
        ),
        'approve': _is.MethodConnector(
          name: 'approve',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'estimateId': _is.ParameterDescription(
              name: 'estimateId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'versionNumber': _is.ParameterDescription(
              name: 'versionNumber',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'contentHash': _is.ParameterDescription(
              name: 'contentHash',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'typedName': _is.ParameterDescription(
              name: 'typedName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _irj2k3gq.CustomerEndpoint).approve(
                    session,
                    params['token'],
                    params['estimateId'],
                    params['versionNumber'],
                    params['contentHash'],
                    params['typedName'],
                  ),
        ),
        'decline': _is.MethodConnector(
          name: 'decline',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'estimateId': _is.ParameterDescription(
              name: 'estimateId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'versionNumber': _is.ParameterDescription(
              name: 'versionNumber',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'contentHash': _is.ParameterDescription(
              name: 'contentHash',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'typedName': _is.ParameterDescription(
              name: 'typedName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _irj2k3gq.CustomerEndpoint).decline(
                    session,
                    params['token'],
                    params['estimateId'],
                    params['versionNumber'],
                    params['contentHash'],
                    params['typedName'],
                    params['reason'],
                  ),
        ),
        'acknowledgeCollection': _is.MethodConnector(
          name: 'acknowledgeCollection',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'typedName': _is.ParameterDescription(
              name: 'typedName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _irj2k3gq.CustomerEndpoint)
                  .acknowledgeCollection(
                    session,
                    params['token'],
                    params['typedName'],
                  ),
        ),
      },
    );
    connectors['evidence'] = _is.EndpointConnector(
      name: 'evidence',
      endpoint: endpoints['evidence']!,
      methodConnectors: {
        'preparePhotoUpload': _is.MethodConnector(
          name: 'preparePhotoUpload',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'opId': _is.ParameterDescription(
              name: 'opId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'contentType': _is.ParameterDescription(
              name: 'contentType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sizeBytes': _is.ParameterDescription(
              name: 'sizeBytes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint)
                  .preparePhotoUpload(
                    session,
                    params['jobId'],
                    params['opId'],
                    params['contentType'],
                    params['sizeBytes'],
                  ),
        ),
        'registerPhoto': _is.MethodConnector(
          name: 'registerPhoto',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'opId': _is.ParameterDescription(
              name: 'opId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'contentType': _is.ParameterDescription(
              name: 'contentType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sha256Hex': _is.ParameterDescription(
              name: 'sha256Hex',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'stage': _is.ParameterDescription(
              name: 'stage',
              type: _is.getType<_ipjl1w58.PhotoStage>(),
              nullable: false,
            ),
            'caption': _is.ParameterDescription(
              name: 'caption',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'capturedAt': _is.ParameterDescription(
              name: 'capturedAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint)
                  .registerPhoto(
                    session,
                    params['jobId'],
                    params['opId'],
                    params['contentType'],
                    params['sha256Hex'],
                    params['stage'],
                    params['caption'],
                    params['capturedAt'],
                  ),
        ),
        'photoUrl': _is.MethodConnector(
          name: 'photoUrl',
          params: {
            'photoId': _is.ParameterDescription(
              name: 'photoId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['evidence'] as _i2cvsm7u.EvidenceEndpoint)
                  .photoUrl(
                    session,
                    params['photoId'],
                  ),
        ),
      },
    );
    connectors['jobs'] = _is.EndpointConnector(
      name: 'jobs',
      endpoint: endpoints['jobs']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jobs'] as _iu8dkase.JobsEndpoint).list(session),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobs'] as _iu8dkase.JobsEndpoint).get(
                session,
                params['jobId'],
              ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'opId': _is.ParameterDescription(
              name: 'opId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_iau16sri.NewJobInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobs'] as _iu8dkase.JobsEndpoint).create(
                session,
                params['opId'],
                params['input'],
              ),
        ),
        'addNote': _is.MethodConnector(
          name: 'addNote',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'opId': _is.ParameterDescription(
              name: 'opId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'customerVisible': _is.ParameterDescription(
              name: 'customerVisible',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'writtenAt': _is.ParameterDescription(
              name: 'writtenAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobs'] as _iu8dkase.JobsEndpoint).addNote(
                session,
                params['jobId'],
                params['opId'],
                params['text'],
                params['customerVisible'],
                params['writtenAt'],
              ),
        ),
        'saveCondition': _is.MethodConnector(
          name: 'saveCondition',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'opId': _is.ParameterDescription(
              name: 'opId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'items': _is.ParameterDescription(
              name: 'items',
              type: _is.getType<List<_it1p0zjf.ConditionItem>>(),
              nullable: false,
            ),
            'capturedAt': _is.ParameterDescription(
              name: 'capturedAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jobs'] as _iu8dkase.JobsEndpoint).saveCondition(
                    session,
                    params['jobId'],
                    params['opId'],
                    params['items'],
                    params['capturedAt'],
                  ),
        ),
        'issueEstimate': _is.MethodConnector(
          name: 'issueEstimate',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'basedOnVersion': _is.ParameterDescription(
              name: 'basedOnVersion',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'lines': _is.ParameterDescription(
              name: 'lines',
              type: _is.getType<List<_ixftu19y.EstimateLine>>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'reasonForRevision': _is.ParameterDescription(
              name: 'reasonForRevision',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jobs'] as _iu8dkase.JobsEndpoint).issueEstimate(
                    session,
                    params['jobId'],
                    params['basedOnVersion'],
                    params['lines'],
                    params['note'],
                    params['reasonForRevision'],
                  ),
        ),
        'startWork': _is.MethodConnector(
          name: 'startWork',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jobs'] as _iu8dkase.JobsEndpoint).startWork(
                    session,
                    params['jobId'],
                  ),
        ),
        'completeRepair': _is.MethodConnector(
          name: 'completeRepair',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jobs'] as _iu8dkase.JobsEndpoint).completeRepair(
                    session,
                    params['jobId'],
                  ),
        ),
        'recordCollection': _is.MethodConnector(
          name: 'recordCollection',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'collectedBy': _is.ParameterDescription(
              name: 'collectedBy',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jobs'] as _iu8dkase.JobsEndpoint)
                  .recordCollection(
                    session,
                    params['jobId'],
                    params['collectedBy'],
                  ),
        ),
      },
    );
    connectors['links'] = _is.EndpointConnector(
      name: 'links',
      endpoint: endpoints['links']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'validDays': _is.ParameterDescription(
              name: 'validDays',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['links'] as _ix0wsr6z.LinksEndpoint).create(
                session,
                params['jobId'],
                params['validDays'],
              ),
        ),
        'revoke': _is.MethodConnector(
          name: 'revoke',
          params: {
            'linkId': _is.ParameterDescription(
              name: 'linkId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['links'] as _ix0wsr6z.LinksEndpoint).revoke(
                session,
                params['linkId'],
              ),
        ),
      },
    );
    connectors['shop'] = _is.EndpointConnector(
      name: 'shop',
      endpoint: endpoints['shop']!,
      methodConnectors: {
        'myShop': _is.MethodConnector(
          name: 'myShop',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['shop'] as _i4fqeydl.ShopEndpoint).myShop(session),
        ),
        'createShop': _is.MethodConnector(
          name: 'createShop',
          params: {
            'shopName': _is.ParameterDescription(
              name: 'shopName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'yourName': _is.ParameterDescription(
              name: 'yourName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['shop'] as _i4fqeydl.ShopEndpoint).createShop(
                    session,
                    params['shopName'],
                    params['yourName'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
