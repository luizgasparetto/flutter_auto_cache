import 'package:flutter/foundation.dart';

import '../enums/substitution_policies.dart';
import 'invalidation_methods/invalidation_method.dart';

@immutable
class DataCacheOptions {
  final SubstitutionPolicies substitutionPolicy;
  final InvalidationMethod invalidationMethod;
  final bool replaceExpiredCache;

  const DataCacheOptions({
    this.substitutionPolicy = SubstitutionPolicies.fifo,
    this.invalidationMethod = const TTLInvalidationMethod(),
    this.replaceExpiredCache = true,
  });

  @override
  bool operator ==(covariant DataCacheOptions other) {
    if (identical(this, other)) return true;

    return other.substitutionPolicy == substitutionPolicy &&
        other.invalidationMethod == invalidationMethod &&
        other.replaceExpiredCache == replaceExpiredCache;
  }

  @override
  int get hashCode => substitutionPolicy.hashCode ^ invalidationMethod.hashCode ^ replaceExpiredCache.hashCode;
}
