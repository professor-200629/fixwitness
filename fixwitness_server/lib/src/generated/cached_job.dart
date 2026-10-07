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
import 'package:serverpod/serverpod.dart' as _is;

/// Device-side cache of job data so the shop app can show jobs offline.
abstract class CachedJob
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CachedJob._({
    this.id,
    required this.serverJobId,
    required this.jobNumber,
    required this.summaryJson,
    this.detailJson,
    required this.cachedAt,
  });

  factory CachedJob({
    int? id,
    required int serverJobId,
    required int jobNumber,
    required String summaryJson,
    String? detailJson,
    required DateTime cachedAt,
  }) = _CachedJobImpl;

  factory CachedJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return CachedJob(
      id: jsonSerialization['id'] as int?,
      serverJobId: jsonSerialization['serverJobId'] as int,
      jobNumber: jsonSerialization['jobNumber'] as int,
      summaryJson: jsonSerialization['summaryJson'] as String,
      detailJson: jsonSerialization['detailJson'] as String?,
      cachedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['cachedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int serverJobId;

  int jobNumber;

  String summaryJson;

  String? detailJson;

  DateTime cachedAt;

  /// Returns a shallow copy of this [CachedJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CachedJob copyWith({
    int? id,
    int? serverJobId,
    int? jobNumber,
    String? summaryJson,
    String? detailJson,
    DateTime? cachedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CachedJob',
      if (id != null) 'id': id,
      'serverJobId': serverJobId,
      'jobNumber': jobNumber,
      'summaryJson': summaryJson,
      if (detailJson != null) 'detailJson': detailJson,
      'cachedAt': cachedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CachedJob',
      if (id != null) 'id': id,
      'serverJobId': serverJobId,
      'jobNumber': jobNumber,
      'summaryJson': summaryJson,
      if (detailJson != null) 'detailJson': detailJson,
      'cachedAt': cachedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CachedJobImpl extends CachedJob {
  _CachedJobImpl({
    int? id,
    required int serverJobId,
    required int jobNumber,
    required String summaryJson,
    String? detailJson,
    required DateTime cachedAt,
  }) : super._(
         id: id,
         serverJobId: serverJobId,
         jobNumber: jobNumber,
         summaryJson: summaryJson,
         detailJson: detailJson,
         cachedAt: cachedAt,
       );

  /// Returns a shallow copy of this [CachedJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CachedJob copyWith({
    Object? id = _Undefined,
    int? serverJobId,
    int? jobNumber,
    String? summaryJson,
    Object? detailJson = _Undefined,
    DateTime? cachedAt,
  }) {
    return CachedJob(
      id: id is int? ? id : this.id,
      serverJobId: serverJobId ?? this.serverJobId,
      jobNumber: jobNumber ?? this.jobNumber,
      summaryJson: summaryJson ?? this.summaryJson,
      detailJson: detailJson is String? ? detailJson : this.detailJson,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }
}
