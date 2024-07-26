import 'package:flutter/material.dart';
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

import 'src/constants/cache_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AutoCacheInitializer.initialize();

  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = CounterStore();

  @override
  void initState() {
    super.initState();
    store.getCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Auto Cache')),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: store,
          builder: (context, count, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: store.decrement, icon: const Icon(Icons.remove)),
                Text(count.toString(), style: const TextStyle(fontSize: 24)),
                IconButton(onPressed: store.increment, icon: const Icon(Icons.add)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CounterStore extends ValueNotifier<int> {
  CounterStore() : super(0);

  Future<void> increment() => _updateCount(() => value += 1);

  Future<void> decrement() => _updateCount(() => value -= 1);

  Future<void> getCount() async {
    final response = await AutoCache.data.getInt(key: CacheConstants.countKey);
    value = response.data ?? 0;
  }

  Future<void> _updateCount(VoidCallback action) async {
    action.call();
    await AutoCache.data.saveInt(key: CacheConstants.countKey, data: value);
  }
}
