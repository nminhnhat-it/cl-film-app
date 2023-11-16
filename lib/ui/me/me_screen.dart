import 'package:ct484_project/ui/me/history_screen.dart';
import 'package:ct484_project/ui/me/setting_screen.dart';
import 'package:ct484_project/ui/me/account_info_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:ct484_project/ui/screens.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Me'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: optionList(context),
      ),
    );
  }

  CupertinoListSection optionList(BuildContext context) {
    return CupertinoListSection(
      children: [
        accountButton(context),
        settingButton(context),
        historyButton(context),
        logInButton(context),
        // logOutButton(context),
      ],
    );
  }

  CupertinoListTile accountButton(BuildContext context) {
    return CupertinoListTile(
      title: const Text('Account name'),
      leadingSize: 100,
      padding: const EdgeInsets.all(50),
      leading: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(100),
          child: Image.network(
            'http://localhost:3000/public/uploads/guest.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const AccountInfoScreen();
          },
        ),
      ),
    );
  }

  CupertinoListTile settingButton(BuildContext context) {
    return CupertinoListTile(
      title: const Text('Settings'),
      leading: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Icon(CupertinoIcons.settings),
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const SettingScreen();
          },
        ),
      ),
    );
  }

  CupertinoListTile historyButton(BuildContext context) {
    return CupertinoListTile(
      title: const Text('History'),
      leading: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Icon(CupertinoIcons.time),
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const HistoryScreen();
          },
        ),
      ),
    );
  }

  CupertinoListTile logOutButton(BuildContext context) {
    return CupertinoListTile(
      title: const Text(
        'Log Out',
        textAlign: TextAlign.center,
      ),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const FavoriteScreen();
          },
        ),
      ),
    );
  }

  CupertinoListTile logInButton(BuildContext context) {
    return CupertinoListTile(
      title: const Text(
        'Log In',
      ),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const FavoriteScreen();
          },
        ),
      ),
    );
  }
}
