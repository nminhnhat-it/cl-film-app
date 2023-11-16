import 'package:ct484_project/ui/me/setting_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:ct484_project/ui/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isDarkTheme = prefs.getBool('isDarkTheme');
  runApp(App(isDarkTheme!));
}

class App extends StatelessWidget {
  final bool isDarkTheme;

  const App(
    this.isDarkTheme, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => SettingManager(isDarkTheme)),
        ],
        builder: (context, child) {
          final themeData = context.watch<SettingManager>();
          return CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: !themeData.themeData
                ? const CupertinoThemeData(brightness: Brightness.light)
                : const CupertinoThemeData(brightness: Brightness.dark),
            home: true ? const Screen() : SplashScreen(),
          );
        });
  }
}

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_fill),
            label: 'Me',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return const HomeScreen();
              case 1:
                return const SearchScreen();
              case 2:
                return const FavoriteScreen();
              case 3:
                return const MeScreen();
              default:
                return const HomeScreen();
            }
          },
        );
      },
    );
  }
}
