import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      ),
    ),
  );
}

const names = [
  'Alice',
  'Bob',
  'Charlie',
  'Dave',
  'Eve',
  'Faythe',
  'Grace',
  'Heidi',
  'Ivan',
  'Judy',
  'Mallory',
  'Oscar',
];

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(seconds: 2),
    (i) => i + 1,
  ),
);

final namesProvider = StreamProvider(
  (ref) =>
      ref.watch(tickerProvider.stream).map((count) => names.getRange(0, count)),
);

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream with Riverpod'),
        centerTitle: true,
      ),
      body: names.when(
        data: (names) {
          return ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(names.elementAt(index)),
              );
            },
          );
        },
        error: (error, stackTrace) => const Text('Reached the end of the list'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
