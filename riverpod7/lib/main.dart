import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod7/providers/provider.dart';
import 'package:riverpod7/widgets/film_widget.dart';
import 'package:riverpod7/widgets/filter_widget.dart';

import 'models/data_model.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod film'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const FilterWidget(),
            Consumer(builder: (context, ref, child) {
              final filter = ref.watch(favoriteStatusProvider);
              switch (filter) {
                case FavoriteStatus.all:
                  return FilmsWidget(
                    provider: allFilmsProvider,
                  );
                case FavoriteStatus.favorite:
                  return FilmsWidget(
                    provider: favotitesFilmsProvider,
                  );
                case FavoriteStatus.notFavorite:
                  return FilmsWidget(
                    provider: notFavotitesFilmsProvider,
                  );
              }
            })
          ],
        ));
  }
}
