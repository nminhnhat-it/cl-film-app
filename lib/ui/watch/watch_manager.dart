import 'package:flutter/cupertino.dart';

class WatchManager with ChangeNotifier {
  int _currentEpNumber = 0;

  set currentEpNumber(int newValue) {
    _currentEpNumber = newValue -1;
    notifyListeners();
  }

  int get currentEpNumber {
    return _currentEpNumber;
  }
}
