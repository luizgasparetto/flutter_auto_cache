import '../../../modules/data_cache/domain/enums/invalidation_types.dart';

final class CacheInvalidationConstants {
  static const defaultInvalidationTypes = InvalidationTypes.ttl;
  static const maxTtlDuration = Duration(days: 1);
}
