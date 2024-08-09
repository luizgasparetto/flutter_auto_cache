import 'package:flutter/foundation.dart';

import '../../shared/functional/equals.dart';

import '../value_objects/cache_metadata.dart';
import '../enums/cache_type.dart';

@immutable
abstract class CacheEntity extends Equals {
  final String id;
  final int usageCount;
  final CacheMetadata metadata;
  final CacheType cacheType;

  const CacheEntity({
    required this.id,
    required this.metadata,
    required this.cacheType,
    this.usageCount = 0,
  });

  @override
  List<Object?> get props => [id];
}
