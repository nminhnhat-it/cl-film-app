import 'package:ct484_project/models/movie.dart';
import 'package:flutter/cupertino.dart';

class SearchManager with ChangeNotifier {
  List<Movie> _movieItems = [];

  get movies {
    return _movieItems;
  }

  set movies(newValue){
    _movieItems = newValue;
    notifyListeners();
  }
}
