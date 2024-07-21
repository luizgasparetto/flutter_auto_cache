import 'package:flutter/foundation.dart';

@immutable
class WriteCacheDTO<T extends Object> {
  final String key;
  final T data;

  const WriteCacheDTO({required this.key, required this.data});

  @override
  bool operator ==(covariant WriteCacheDTO<T> other) {
    if (identical(this, other)) return true;

    return other.key == key && other.data == data;
  }

  @override
  int get hashCode => key.hashCode ^ data.hashCode;
}
