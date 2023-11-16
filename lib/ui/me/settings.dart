import 'package:flutter/cupertino.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: CupertinoFormSection(
              header: const Text('Theme'),
              children: <Widget>[
                CupertinoFormRow(
                  prefix: const Text('Dark Theme'),
                  child: CupertinoSwitch(
                    value: isDarkTheme,
                    onChanged: (value) {
                      setState(() {
                        isDarkTheme = value;
                      });
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
