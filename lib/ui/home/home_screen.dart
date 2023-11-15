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
        top: 110,
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
              builder: (BuildContext context) => const WatchScreen(),
            ),
          ),
          child: Image.network(
            'http://localhost:3000/public/uploads/sndyf24n24m.png',
            fit: BoxFit.cover,
          ),
        ),
        const Flexible(
          child: Text(
            'Anime Name',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
