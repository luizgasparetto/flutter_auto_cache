import 'package:flutter/foundation.dart';

import '../enums/cache_cryptography_algorithms.dart';

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

  final CacheCryptographyAlgorithms algorithm;

  /// Constructs cache cryptography options with a customizable secret key.
  const CacheCryptographyOptions({
    required this.secretKey,
    this.algorithm = CacheCryptographyAlgorithms.aes,
  });

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => secretKey.hashCode ^ algorithm.hashCode;
}
