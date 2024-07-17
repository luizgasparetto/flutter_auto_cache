import 'package:example/src/home/constants/cache_constants.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

class CounterStore extends ValueNotifier<int> {
  CounterStore() : super(0);

  Future<void> getCount() async {
    final response = await AutoCache.data.getInt(key: CacheConstants.countKey);
    value = response.data ?? 0;
  }

  Future<void> increment() => _updateCount(() => value += 1);

  Future<void> decrement() => _updateCount(() => value -= 1);

  Future<void> _updateCount(VoidCallback action) async {
    action.call();

    await AutoCache.data.saveInt(key: CacheConstants.countKey, data: value);
  }
}
