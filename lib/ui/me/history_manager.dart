import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/services/movie_service.dart';
import 'package:flutter/cupertino.dart';

class HistoryManager with ChangeNotifier {
  final MoviesService _moviesService = MoviesService();

  List<Movie> _historyItems = [];

  get history {
    return _historyItems;
  }

  set history(newValue) {
    _historyItems = newValue;
    notifyListeners();
  }

  Future<void> fetchHistory(token) async {
    history = await _moviesService.fetchHistory(token);
  }

  Future<void> addHistory(token, mvId, epNumber) async {
    await _moviesService.addHistory(token, mvId, epNumber);
    fetchHistory(token);
  }
}
