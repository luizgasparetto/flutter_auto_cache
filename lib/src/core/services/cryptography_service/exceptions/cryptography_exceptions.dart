import '../../../core.dart';

class EncryptException extends AutoCacheException {
  EncryptException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'fail-encrypt');
}

class DecryptException extends AutoCacheException {
  DecryptException({
    required super.message,
    required super.stackTrace,
  }) : super(code: 'fail-decrypt');
}
