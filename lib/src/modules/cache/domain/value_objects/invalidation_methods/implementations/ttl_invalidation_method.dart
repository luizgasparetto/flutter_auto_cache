import '../../../enums/invalidation_type.dart';
import '../invalidation_method.dart';

class TTLInvalidationMethod extends InvalidationMethod {
  final Duration ttlDuration;

  TTLInvalidationMethod({
    Duration? ttlDuration,
  }) : ttlDuration = ttlDuration ?? const Duration(days: 1);

  @override
  InvalidationType get invalidationType => InvalidationType.ttl;
}
