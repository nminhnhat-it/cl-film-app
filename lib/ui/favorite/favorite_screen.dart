import 'package:flutter/cupertino.dart';

import 'package:ct484_project/ui/screens.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Favorite'),
      ),
      child: Center(
        child: FavoriteMovieGrid(),
      ),
    );
  }
}

class FavoriteMovieGrid extends StatelessWidget {
  const FavoriteMovieGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
        top: 115,
        left: 10,
        right: 10,
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

class FavoriteMovieCard extends StatelessWidget {
  const FavoriteMovieCard({
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
                    'https://s102.imacdn.com/vg/2017/09/11/5781_126831.mp4?hash=QIli4l4gPDZPZmQrP9oFYw&expire=1700000426&title=Rumiko',
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
