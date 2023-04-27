import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuto_riverpod1/providers/counter_provider.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    ),
  ));
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int value = ref.watch(counterStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Counter'),
      ),
      body: Column(children: [
        Center(
          child: Text(
            'Value : $value',
            style: const TextStyle(fontSize: 24),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            ref.read(counterStateProvider.notifier).state++;
          },
          child: const Icon(Icons.add),
        ),
      ]),
    );
  }
}
