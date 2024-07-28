import 'package:flutter/foundation.dart';

class AutoCacheNotifier<T extends Object> extends ValueNotifier<T> {
  final T initialValue;

  AutoCacheNotifier(this.initialValue) : super(initialValue);

  void setData(T data) => value = data;
  void reset() => value = initialValue;
}
