import 'package:flutter/foundation.dart';

import '../enums/substitution_policies.dart';
import 'invalidation_methods/invalidation_method.dart';

@immutable
class DataCacheOptions {
  final SubstitutionPolicies substitutionPolicy;
  final InvalidationMethod invalidationMethod;

  const DataCacheOptions({
    this.substitutionPolicy = SubstitutionPolicies.fifo,
    this.invalidationMethod = const TTLInvalidationMethod(),
  });

  @override
  bool operator ==(covariant DataCacheOptions other) {
    if (identical(this, other)) return true;

    return other.substitutionPolicy == substitutionPolicy && other.invalidationMethod == invalidationMethod;
  }

  @override
  int get hashCode => substitutionPolicy.hashCode ^ invalidationMethod.hashCode;
}
