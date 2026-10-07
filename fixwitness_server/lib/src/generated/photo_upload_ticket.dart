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

/// Answer to preparePhotoUpload. When `alreadyStored` is true the bytes from an
/// earlier attempt are on the server and the device should only register them.
abstract class PhotoUploadTicket
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PhotoUploadTicket._({
    required this.alreadyStored,
    this.uploadDescription,
    required this.maxBytes,
  });

  factory PhotoUploadTicket({
    required bool alreadyStored,
    String? uploadDescription,
    required int maxBytes,
  }) = _PhotoUploadTicketImpl;

  factory PhotoUploadTicket.fromJson(Map<String, dynamic> jsonSerialization) {
    return PhotoUploadTicket(
      alreadyStored: _is.BoolJsonExtension.fromJson(
        jsonSerialization['alreadyStored'],
      ),
      uploadDescription: jsonSerialization['uploadDescription'] as String?,
      maxBytes: jsonSerialization['maxBytes'] as int,
    );
  }

  bool alreadyStored;

  String? uploadDescription;

  int maxBytes;

  /// Returns a shallow copy of this [PhotoUploadTicket]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PhotoUploadTicket copyWith({
    bool? alreadyStored,
    String? uploadDescription,
    int? maxBytes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PhotoUploadTicket',
      'alreadyStored': alreadyStored,
      if (uploadDescription != null) 'uploadDescription': uploadDescription,
      'maxBytes': maxBytes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PhotoUploadTicket',
      'alreadyStored': alreadyStored,
      if (uploadDescription != null) 'uploadDescription': uploadDescription,
      'maxBytes': maxBytes,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PhotoUploadTicketImpl extends PhotoUploadTicket {
  _PhotoUploadTicketImpl({
    required bool alreadyStored,
    String? uploadDescription,
    required int maxBytes,
  }) : super._(
         alreadyStored: alreadyStored,
         uploadDescription: uploadDescription,
         maxBytes: maxBytes,
       );

  /// Returns a shallow copy of this [PhotoUploadTicket]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PhotoUploadTicket copyWith({
    bool? alreadyStored,
    Object? uploadDescription = _Undefined,
    int? maxBytes,
  }) {
    return PhotoUploadTicket(
      alreadyStored: alreadyStored ?? this.alreadyStored,
      uploadDescription: uploadDescription is String?
          ? uploadDescription
          : this.uploadDescription,
      maxBytes: maxBytes ?? this.maxBytes,
    );
  }
}
