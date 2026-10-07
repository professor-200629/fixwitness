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
import 'photo_stage.dart' as _izmwwpv6;

abstract class CustomerPhoto
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerPhoto._({
    required this.id,
    required this.stage,
    this.caption,
    required this.capturedAt,
    required this.url,
  });

  factory CustomerPhoto({
    required int id,
    required _izmwwpv6.PhotoStage stage,
    String? caption,
    required DateTime capturedAt,
    required String url,
  }) = _CustomerPhotoImpl;

  factory CustomerPhoto.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerPhoto(
      id: jsonSerialization['id'] as int,
      stage: _izmwwpv6.PhotoStage.fromJson(
        (jsonSerialization['stage'] as String),
      ),
      caption: jsonSerialization['caption'] as String?,
      capturedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['capturedAt'],
      ),
      url: jsonSerialization['url'] as String,
    );
  }

  int id;

  _izmwwpv6.PhotoStage stage;

  String? caption;

  DateTime capturedAt;

  String url;

  /// Returns a shallow copy of this [CustomerPhoto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerPhoto copyWith({
    int? id,
    _izmwwpv6.PhotoStage? stage,
    String? caption,
    DateTime? capturedAt,
    String? url,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerPhoto',
      'id': id,
      'stage': stage.toJson(),
      if (caption != null) 'caption': caption,
      'capturedAt': capturedAt.toJson(),
      'url': url,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerPhoto',
      'id': id,
      'stage': stage.toJson(),
      if (caption != null) 'caption': caption,
      'capturedAt': capturedAt.toJson(),
      'url': url,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerPhotoImpl extends CustomerPhoto {
  _CustomerPhotoImpl({
    required int id,
    required _izmwwpv6.PhotoStage stage,
    String? caption,
    required DateTime capturedAt,
    required String url,
  }) : super._(
         id: id,
         stage: stage,
         caption: caption,
         capturedAt: capturedAt,
         url: url,
       );

  /// Returns a shallow copy of this [CustomerPhoto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerPhoto copyWith({
    int? id,
    _izmwwpv6.PhotoStage? stage,
    Object? caption = _Undefined,
    DateTime? capturedAt,
    String? url,
  }) {
    return CustomerPhoto(
      id: id ?? this.id,
      stage: stage ?? this.stage,
      caption: caption is String? ? caption : this.caption,
      capturedAt: capturedAt ?? this.capturedAt,
      url: url ?? this.url,
    );
  }
}
