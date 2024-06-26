import '../../../../core/core.dart';

class ExpiredTTLFailure extends AutoCacheFailure {
  ExpiredTTLFailure({required super.message}) : super(code: 'expired_ttl');
}
