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

  Future<List<Movie>> fetchFavoriteMovies(token) async {
    final List<Movie> movies = [];
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/movies/favorites'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': 'token=$token',
      },
    );
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

  Future<List<Movie>> fetchHistory(token) async {
    final List<Movie> movies = [];
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/movies/histories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': 'token=$token',
      },
    );
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

  Future<void> addHistory(token, mvId, epNumber) async {
    await http.post(Uri.parse('http://localhost:3000/api/movies/histories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': 'token=$token',
        },
        body: jsonEncode({"mv_id": mvId, "ep_number": epNumber}));
  }

  Future<void> addFavorite(token, mvId) async {
    await http.post(Uri.parse('http://localhost:3000/api/movies/favorites'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': 'token=$token',
        },
        body: jsonEncode({"mv_id": mvId}));
  }

  Future<void> deleteFavorite(token, mvId) async {
    await http.delete(Uri.parse('http://localhost:3000/api/movies/favorites'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': 'token=$token',
        },
        body: jsonEncode({"mv_id": mvId}));
  }
}
