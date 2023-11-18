import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/services/movie_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:ct484_project/models/category.dart';

class HomeManager with ChangeNotifier {
  final MoviesService _moviesService = MoviesService();

  get categories {
    return _categoryItems;
  }

  get movies {
    return _movieItems;
  }

  List<Category> _categoryItems = [];
  List<Movie> _movieItems = [];

  Future<void> fetchCategories() async {
    _categoryItems = await _moviesService.fetchCategories();
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    _movieItems = await _moviesService.fetchMovies();
    notifyListeners();
  }
}
