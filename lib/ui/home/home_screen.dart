import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/ui/home/home_manager.dart';
import 'package:flutter/cupertino.dart';

import 'package:ct484_project/ui/screens.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeManager>().fetchCategories();
    context.read<HomeManager>().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bliibii TV',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: Color.fromARGB(255, 51, 161, 204),
              ),
            ),
          ],
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 40,
            margin: const EdgeInsets.only(
              top: 100,
            ),
            child: const CategorySlideBar(),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 140,
              bottom: 80,
            ),
            child: const MovieGrid(),
          ),
        ],
      ),
    );
  }
}

class CategorySlideBar extends StatelessWidget {
  const CategorySlideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeManager>(
      builder: (context, categoryManager, child) => ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var category in categoryManager.categories)
            GestureDetector(
              onTap: () => {print(category.id)},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  category.kName,
                  style: const TextStyle(
                    color: CupertinoColors.activeBlue,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  const MovieGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeManager>(
      builder: (context, categoryManager, child) => GridView.builder(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        itemCount: categoryManager.movies.length,
        itemBuilder: (context, i) => MovieCard(categoryManager.movies[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 30,
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie _movie;

  const MovieCard(this._movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context, rootNavigator: true).push(
            CupertinoPageRoute(
              builder: (BuildContext context) => WatchScreen(
                _movie,
                _movie.episodes,
                1,
              ),
            ),
          ),
          child: Image.network(
            'http://localhost:3000/${_movie.mvImage}',
            height: 170,
            fit: BoxFit.cover,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              _movie.mvName,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
