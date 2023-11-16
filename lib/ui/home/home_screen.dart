import 'package:flutter/cupertino.dart';

import 'package:ct484_project/ui/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Center(
        child: MovieGrid(),
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  const MovieGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
        top: 115,
        left: 10,
        right: 10,
        bottom: 110,
      ),
      itemCount: 100,
      itemBuilder: (context, i) => const MovieCard(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 30,
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute(
              // builder: (BuildContext context) => const FavoriteScreen()
              builder: (BuildContext context) => const WatchScreen(
                videoLink:
                    'https://s102.imacdn.com/vg/2017/09/11/5781_126832.mp4?hash=jYImSyhcN5sKeylZd7Lkaw&expire=1700000449&title=Rumiko%20Takahashi%20Anthology%20Tập%202%20-%20Thương%20nhân%20lãng%20mạn%20(480p)',
              ),
            ),
          ),
          child: Image.network(
            'http://localhost:3000/public/uploads/sndyf24n24m.png',
            fit: BoxFit.cover,
          ),
        ),
        const Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              'Movie Name',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
