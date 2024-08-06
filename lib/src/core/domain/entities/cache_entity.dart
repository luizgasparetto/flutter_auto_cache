import 'package:flutter/foundation.dart';
import 'package:flutter_auto_cache/src/core/domain/enums/cache_type.dart';

import '../../shared/functional/equals.dart';
import '../value_objects/cache_metadata.dart';

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

  String get key => '${cacheType.name}-$id';

  @override
  List<Object?> get props => [id];
}
