import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  Future<void> setThemeData(bool newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', newValue);
  }

  Future<bool?> loadThemeData() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isDarkTheme = prefs.getBool('isDarkTheme');
    return isDarkTheme;
  }
}
