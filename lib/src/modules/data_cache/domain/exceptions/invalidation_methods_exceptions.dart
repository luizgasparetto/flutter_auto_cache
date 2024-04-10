import '../../../../core/core.dart';

class TTLInvalidationMethodException extends AutoCacheManagerException {
  TTLInvalidationMethodException({
    required super.code,
    required super.message,
    required super.stackTrace,
  });
}

class ExpiredTTLException extends TTLInvalidationMethodException {
  ExpiredTTLException()
      : super(
            code: 'expired_ttl',
            stackTrace: StackTrace.empty,
            message: 'Expired TTL');
}
