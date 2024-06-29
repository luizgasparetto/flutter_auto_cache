import 'package:flutter/foundation.dart';

import '../enums/invalidation_types.dart';
import '../enums/substitution_policies.dart';

@immutable
class DataCacheOptions {
  final InvalidationTypes invalidationType;
  final SubstitutionPolicies substitutionPolicy;
  final Duration ttlMaxDuration;
  final bool replaceExpiredCache;

  DataCacheOptions._({
    required this.invalidationType,
    required this.substitutionPolicy,
    required this.ttlMaxDuration,
    required this.replaceExpiredCache,
  }) : assert(_assertTtlConfig(invalidationType, ttlMaxDuration));

  factory DataCacheOptions.defaultConfig() {
    return DataCacheOptions._(
      invalidationType: InvalidationTypes.ttl,
      substitutionPolicy: SubstitutionPolicies.fifo,
      ttlMaxDuration: const Duration(days: 1),
      replaceExpiredCache: true,
    );
  }

  static bool _assertTtlConfig(InvalidationTypes invalidationType, Duration? ttlMaxDuration) {
    final isNotTtl = invalidationType != InvalidationTypes.ttl;
    final isTtlDurationValid = ttlMaxDuration != null && ttlMaxDuration != Duration.zero;

    return isNotTtl || isTtlDurationValid;
  }

  @override
  bool operator ==(covariant DataCacheOptions other) => identical(this, other);

  @override
  int get hashCode => invalidationType.hashCode ^ ttlMaxDuration.hashCode ^ replaceExpiredCache.hashCode;
}
