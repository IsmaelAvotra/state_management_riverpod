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

enum City {
  marraKech,
  paris,
  tokyo,
}

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) async {
  await Future.delayed(const Duration(seconds: 1));
  switch (city) {
    case City.marraKech:
      return '☀️';
    case City.paris:
      return '🌧️';
    case City.tokyo:
      return '🌩️';
  }
}

const unknowWeatherEmoji = '🤷‍♂️';

//will be changed by the ui
final currentCityProvider = StateProvider<City?>((ref) => null);

//will be listen by the ui
final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return unknowWeatherEmoji;
  }
});

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Riverpod App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          currentWeather.when(
            data: (weather) =>
                Text(weather, style: const TextStyle(fontSize: 50)),
            loading: () => const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator()),
            error: (error, stackTrace) => const Text('Error: 😢'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (context, index) {
                final city = City.values[index];

                final isSelected = city == ref.watch(currentCityProvider);
                return ListTile(
                  title: Text(
                    city.toString(),
                    style: TextStyle(
                        color: isSelected ? Colors.red : Colors.white),
                  ),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () {
                    ref.read(currentCityProvider.notifier).state = city;
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
