import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;

    if (shadow != null) {
      return shadow + (other ?? 0) as T?;
    } else {
      return null;
    }
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);

  void increment() => state = state == null ? 1 : state + 1;
}

final counterProvider =
    StateNotifierProvider<Counter, int?>((ref) => Counter());

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter Hooks Riverpod'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).increment();
                },
                child: const Text('Increment Counter'),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final counter = ref.watch(counterProvider);
                  final text =
                      counter == null ? "Press the button" : counter.toString();
                  return Text(
                    text,
                    style: const TextStyle(fontSize: 20),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
