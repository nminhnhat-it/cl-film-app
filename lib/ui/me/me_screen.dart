import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/me/history_screen.dart';
import 'package:ct484_project/ui/me/account_info_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:ct484_project/ui/screens.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
      builder: (context, authManager, child) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Me'),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: CupertinoListSection(
            children: authManager.user == null
                ? [
                    accountButton(context),
                    settingButton(context),
                    signInButton(context)
                  ]
                : [
                    accountButton(context),
                    settingButton(context),
                    historyButton(context),
                    logOutButton(context),
                  ],
          ),
        ),
      ),
    );
  }

  CupertinoListTile accountButton(BuildContext context) {
    return CupertinoListTile(
      title: context.read<AuthManager>().user == null
          ? const Text('Guest')
          : Text(context.read<AuthManager>().user.usName),
      leadingSize: 100,
      padding: const EdgeInsets.all(50),
      leading: Consumer<AuthManager>(
        builder: (context, authManager, child) => ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(100),
            child: authManager.user == null
                ? Image.network(
                    '${dotenv.env['API_HOST']}/public/uploads/guest.png',
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    '${dotenv.env['API_HOST']}/${authManager.user.usImage}',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
      onTap: () => context.read<AuthManager>().user != null
          ? Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute<void>(
                builder: (BuildContext context) {
                  return const AccountInfoScreen();
                },
              ),
            )
          : () {},
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
      onTap: () => Navigator.of(context, rootNavigator: true).push(
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
      onTap: () => Navigator.of(context, rootNavigator: true).push(
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
        onTap: () {
          context.read<AuthManager>().removeToken();
        });
  }

  CupertinoListTile signInButton(BuildContext context) {
    return CupertinoListTile(
      title: const Text(
        'Sign In',
      ),
      onTap: () => Navigator.of(context, rootNavigator: true).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const AuthScreen();
          },
        ),
      ),
    );
  }
}
