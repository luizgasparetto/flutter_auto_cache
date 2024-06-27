import '../../../../core/core.dart';

class ExpiredTTLFailure extends AutoCacheFailure {
  ExpiredTTLFailure() : super(code: 'expired_ttl', message: 'The content of cache is expired by TTL');
}
