import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod7/models/data_model.dart';

//Provider for the status of the favorite status
final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (_) => FavoriteStatus.all,
);

//for all films
final allFilmsProvider = StateNotifierProvider<FilmNotifier, List<Film>>(
  (_) => FilmNotifier(),
);

//for favorite films
final favotitesFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where((film) => film.isFavorite),
);

//for not favorite films
final notFavotitesFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where((film) => !film.isFavorite),
);
