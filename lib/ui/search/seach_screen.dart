import 'package:flutter/cupertino.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Search')
      ),
      child: Text('data')
    );
  }
}
