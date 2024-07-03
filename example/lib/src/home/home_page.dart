import 'package:example/src/home/stores/counter_store.dart';
import 'package:flutter/material.dart';

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
