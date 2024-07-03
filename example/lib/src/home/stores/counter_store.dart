import 'package:example/src/home/constants/cache_constants.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

class CounterStore extends ValueNotifier<int> {
  CounterStore() : super(0);

  Future<void> getCount() async {
    final response = await AutoCache.prefs.getInt(key: CacheConstants.countKey);
    value = response ?? 0;
  }

  Future<void> increment() => _writeInt(() => value += 1);

  Future<void> decrement() => _writeInt(() => value -= 1);

  Future<void> _writeInt(VoidCallback action) async {
    action.call();
    await AutoCache.prefs.saveInt(key: CacheConstants.countKey, data: value);
  }
}
