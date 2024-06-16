import '../../../../core/core.dart';

sealed class TTLInvalidationMethodException extends AutoCacheFailure {
  TTLInvalidationMethodException({
    required super.code,
    required super.message,
  });
}

class ExpiredTTLException extends TTLInvalidationMethodException {
  ExpiredTTLException()
      : super(
          code: 'expired_ttl',
          stackTrace: StackTrace.empty,
          message: 'Expired TTL',
        );
}
