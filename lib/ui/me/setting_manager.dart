import 'package:flutter/cupertino.dart';
import 'package:ct484_project/services/setting_service.dart';

class SettingManager with ChangeNotifier {
  final SettingService _settingService = SettingService();

  bool _isDarkTheme;

  SettingManager(this._isDarkTheme);

  bool get themeData {
    return _isDarkTheme;
  }

  set themeData(bool newValue) {
    _settingService.setThemeData(newValue);
    _isDarkTheme = newValue;
    notifyListeners();
  }
}
