import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/favorite/favorite_manager.dart';
import 'package:ct484_project/ui/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    context
        .read<FavoriteManager>()
        .fetchFavoriteMovies(context.read<AuthManager>().token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favorite'),
      ),
      child: Consumer2<AuthManager, FavoriteManager>(
        builder: (context, authManager, favoriteManager, child) => Center(
          child: authManager.user != null
              ? favoriteManager.favoriteMovies.length != 0
                  ? const FavoriteMovieGrid()
                  : const Text('You don\'t have any favorite movies')
              : const Text('Sign in to manage your Favorite'),
        ),
      ),
    );
  }
}

class FavoriteMovieGrid extends StatelessWidget {
  const FavoriteMovieGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteManager>(
      builder: (context, favoriteManager, child) => GridView.builder(
        padding: const EdgeInsets.only(
          top: 115,
          left: 10,
          right: 10,
        ),
        itemCount: favoriteManager.favoriteMovies.length,
        itemBuilder: (context, i) =>
            FavoriteMovieCard(favoriteManager.favoriteMovies[i]),
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

class FavoriteMovieCard extends StatelessWidget {
  final Movie _movie;

  const FavoriteMovieCard(this._movie, {super.key});

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
            '${dotenv.env['API_HOST']}/${_movie.mvImage}',
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
