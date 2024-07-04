// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

/// Represents cache cryptography options with a configurable secret key.
///
/// This class allows the definition of cache cryptography options for applications,
/// providing a flexible way to define the secret key for cryptography,
/// enhancing security.
@immutable
class CacheCryptographyOptions {
  final String secretKey;

  CacheCryptographyOptions({required this.secretKey}) : assert(secretKey.isNotEmpty, _assertErrorMessage);

  static const String _assertErrorMessage = 'Secret key cannot be empty. Please provide a non-empty string as the secret key.';

  @override
  bool operator ==(covariant CacheCryptographyOptions other) {
    if (identical(this, other)) return true;

    return other.secretKey == secretKey;
  }

  @override
  int get hashCode => secretKey.hashCode;
}
