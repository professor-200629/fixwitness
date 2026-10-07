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
import 'package:fixwitness_client/src/protocol/protocol.dart' as _i7z9lov6;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'customer_link.dart' as _iwkslo03;

/// Returned once when a customer link is created. `url` contains the secret token.
abstract class CreatedLink
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CreatedLink._({
    required this.link,
    required this.url,
  });

  factory CreatedLink({
    required _iwkslo03.CustomerLink link,
    required String url,
  }) = _CreatedLinkImpl;

  factory CreatedLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreatedLink(
      link: _i7z9lov6.Protocol().deserialize<_iwkslo03.CustomerLink>(
        jsonSerialization['link'],
      ),
      url: jsonSerialization['url'] as String,
    );
  }

  _iwkslo03.CustomerLink link;

  String url;

  /// Returns a shallow copy of this [CreatedLink]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CreatedLink copyWith({
    _iwkslo03.CustomerLink? link,
    String? url,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreatedLink',
      'link': link.toJson(),
      'url': url,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreatedLink',
      'link': link.toJsonForProtocol(),
      'url': url,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _CreatedLinkImpl extends CreatedLink {
  _CreatedLinkImpl({
    required _iwkslo03.CustomerLink link,
    required String url,
  }) : super._(
         link: link,
         url: url,
       );

  /// Returns a shallow copy of this [CreatedLink]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CreatedLink copyWith({
    _iwkslo03.CustomerLink? link,
    String? url,
  }) {
    return CreatedLink(
      link: link ?? this.link.copyWith(),
      url: url ?? this.url,
    );
  }
}
