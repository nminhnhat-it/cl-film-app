import 'package:ct484_project/ui/me/setting_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Consumer<SettingManager>(
              builder: (context, data, child) => CupertinoFormSection(
                header: const Text('Theme'),
                children: <Widget>[
                  CupertinoFormRow(
                    prefix: const Text('Dark Theme'),
                    child: CupertinoSwitch(
                      value: data.themeData,
                      onChanged: (value) {
                        data.themeData = value;
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
