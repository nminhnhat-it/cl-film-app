import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/services/movie_service.dart';
import 'package:flutter/cupertino.dart';

class FavoriteManager with ChangeNotifier {
  final MoviesService _moviesService = MoviesService();

  List<Movie> _favoriteMovieItems = [];

  get favoriteMovies {
    return _favoriteMovieItems;
  }

  Future<void> fetchFavoriteMovies() async {
    _favoriteMovieItems = await _moviesService.fetchFavoriteMovies();
    notifyListeners();
  }
}
