import 'package:flutter_auto_cache/flutter_auto_cache.dart';

import 'package:example/src/app_widget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await AutoCacheInitializer.init();

  runApp(const AppWidget());
}
