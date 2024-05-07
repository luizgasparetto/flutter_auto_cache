import '../enums/invalidation_type.dart';

final class CacheConstants {
  static const defaultInvalidationType = InvalidationType.ttl;

  static const maxTtlDuration = Duration(days: 1);
}
