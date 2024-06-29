import 'package:flutter/foundation.dart';

import '../enums/invalidation_types.dart';
import '../enums/substitution_policies.dart';

@immutable
class DataCacheOptions {
  final InvalidationTypes invalidationType;
  final SubstitutionPolicies substitutionPolicy;
  final Duration ttlMaxDuration;
  final bool replaceExpiredCache;

  DataCacheOptions({
    this.invalidationType = InvalidationTypes.ttl,
    this.substitutionPolicy = SubstitutionPolicies.fifo,
    this.ttlMaxDuration = const Duration(days: 1),
    this.replaceExpiredCache = true,
  }) : assert(_assertTtlConfig(invalidationType, ttlMaxDuration));

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
