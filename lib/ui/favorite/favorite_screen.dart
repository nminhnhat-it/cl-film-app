import 'package:flutter/cupertino.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Favorite')
      ),
      child: Text('data')
    );
  }
}
