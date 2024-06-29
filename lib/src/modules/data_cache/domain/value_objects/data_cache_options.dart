// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  bool operator ==(covariant DataCacheOptions other) {
    if (identical(this, other)) return true;

    return other.invalidationType == invalidationType &&
        other.substitutionPolicy == substitutionPolicy &&
        other.ttlMaxDuration == ttlMaxDuration &&
        other.replaceExpiredCache == replaceExpiredCache;
  }

  @override
  int get hashCode {
    return invalidationType.hashCode ^
        substitutionPolicy.hashCode ^
        ttlMaxDuration.hashCode ^
        replaceExpiredCache.hashCode;
  }
}
