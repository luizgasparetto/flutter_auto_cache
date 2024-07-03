import 'package:flutter/foundation.dart';

/// Represents cache cryptography options with a configurable secret key.
///
/// This class allows the definition of cache cryptography options for applications,
/// providing a flexible way to define the secret key for cryptography,
/// enhancing security.
@immutable
class CacheCryptographyOptions {
  final String secretKey;

  const CacheCryptographyOptions({required this.secretKey});

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => secretKey.hashCode;
}
