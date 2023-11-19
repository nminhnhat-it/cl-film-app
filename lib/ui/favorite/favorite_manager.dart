import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/services/movie_service.dart';
import 'package:flutter/cupertino.dart';

class FavoriteManager with ChangeNotifier {
  final MoviesService _moviesService = MoviesService();

  List<Movie> _favoriteMovieItems = [];

  get favoriteMovies {
    return _favoriteMovieItems;
  }

  set favoriteMovies(newValue) {
    _favoriteMovieItems = newValue;
    notifyListeners();
  }

  Future<void> fetchFavoriteMovies(token) async {
    favoriteMovies = await _moviesService.fetchFavoriteMovies(token);
  }

  Future<void> addFavorite(token, mvId) async {
    await _moviesService.addFavorite(token, mvId);
    fetchFavoriteMovies(token);
  }
  Future<void> deleteFavorite(token, mvId) async {
    await _moviesService.deleteFavorite(token, mvId);
    fetchFavoriteMovies(token);
  }
}
