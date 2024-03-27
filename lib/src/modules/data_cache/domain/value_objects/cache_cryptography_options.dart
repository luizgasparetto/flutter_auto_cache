import 'package:flutter/foundation.dart';

/// Represents cache cryptography options with a configurable secret key.
///
/// This class allows the definition of cache cryptography options for applications,
/// providing a flexible way to define the secret key for cryptography,
/// enhancing security.
///
@immutable
class CacheCryptographyOptions {
  /// The secret key used for encrypting the cache.
  final String secretKey;

  /// Constructs cache cryptography options with a customizable secret key.
  const CacheCryptographyOptions({
    required this.secretKey,
  });
}
