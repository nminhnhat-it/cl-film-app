import 'package:flutter/cupertino.dart';

import 'package:ct484_project/ui/screens.dart';


class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Watch'),
      ),
      child: Center(
        child: Text('Watch'),
      ),
    );
  }
}