import 'package:flutter/foundation.dart';

import '../../shared/functional/equals.dart';
import '../value_objects/cache_metadata.dart';

@immutable
class CacheEntity<T extends Object> extends Equals {
  final String id;
  final T data;
  final int usageCount;
  final CacheMetadata metadata;

  const CacheEntity({
    required this.id,
    required this.data,
    required this.metadata,
    this.usageCount = 0,
  });

  @override
  List<Object?> get props => [id];
}
