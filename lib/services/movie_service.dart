import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ct484_project/models/category.dart';
import 'package:ct484_project/models/movie.dart';

class MoviesService {
  Future<List<Category>> fetchCategories() async {
    final List<Category> categories = [];

    final response =
        await http.get(Uri.parse('http://localhost:3000/api/kinds'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map index in data) {
        categories.add(Category.fromJson(index));
      }
      return categories;
    } else {
      return categories;
    }
  }

  Future<List<Movie>> fetchMovies() async {
    final List<Movie> movies = [];

    final response =
        await http.get(Uri.parse('http://localhost:3000/api/movies'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map index in data) {
        movies.add(Movie.fromJson(index));
      }
      return movies;
    } else {
      return movies;
    }
  }

  Future<List<Movie>> fetchFavoriteMovies() async {
    final List<Movie> movies = [];

    final response =
        await http.get(Uri.parse('http://localhost:3000/api/movies'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map index in data) {
        if (Movie.fromJson(index).isFavorite == true) {
          movies.add(Movie.fromJson(index));
        }
      }
      return movies;
    } else {
      return movies;
    }
  }
}
