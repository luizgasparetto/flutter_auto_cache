import '../../../modules/data_cache/domain/enums/invalidation_type.dart';

final class CacheInvalidationConstants {
  static const defaultInvalidationType = InvalidationType.ttl;
  static const maxTtlDuration = Duration(days: 1);
}
