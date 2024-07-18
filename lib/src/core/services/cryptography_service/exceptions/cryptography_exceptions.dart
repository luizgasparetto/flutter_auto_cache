import '../../../errors/auto_cache_error.dart';

/// Exception thrown when an encryption operation fails.
///
/// This exception is a specific type of [AutoCacheException] that is
/// thrown when there is a failure in encrypting data.
class EncryptException extends AutoCacheException {
  EncryptException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'fail-encrypt');
}

/// Exception thrown when a decryption operation fails.
///
/// This exception is a specific type of [AutoCacheException] that is
/// thrown when there is a failure in decrypting data.
class DecryptException extends AutoCacheException {
  DecryptException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'fail-decrypt');
}
