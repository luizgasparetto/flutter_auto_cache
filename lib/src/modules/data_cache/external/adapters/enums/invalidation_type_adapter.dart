import '../../../domain/enums/invalidation_type.dart';

class InvalidationTypeAdapter {
  static InvalidationType fromKey(String key) {
    return switch (key) {
      'refresh' => InvalidationType.refresh,
      'ttl' => InvalidationType.ttl,
      _ => InvalidationType.refresh,
    };
  }

  static String toKey(InvalidationType type) {
    return switch (type) {
      InvalidationType.refresh => 'refresh',
      InvalidationType.ttl => 'ttl',
    };
  }
}
