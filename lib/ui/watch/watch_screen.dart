import 'package:ct484_project/models/episode.dart';
import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/favorite/favorite_manager.dart';
import 'package:ct484_project/ui/me/history_manager.dart';
import 'package:ct484_project/ui/watch/watch_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import './video_player.dart';

class WatchScreen extends StatefulWidget {
  final Movie _movie;
  final List<Episode> _episodes;
  final int episodeNumber;

  const WatchScreen(this._movie, this._episodes, this.episodeNumber,
      {super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  @override
  void initState() {
    if (context.read<AuthManager>().token != null) {
      context
          .read<FavoriteManager>()
          .fetchFavoriteMovies(context.read<AuthManager>().token);

      context.read<HistoryManager>().addHistory(
          context.read<AuthManager>().token,
          widget._movie.id,
          widget.episodeNumber);
    }
    super.initState();
  }

  bool isFavorite(favoriteMovies) {
    var val = false;
    for (var movie in favoriteMovies) {
      if (widget._movie.id == movie.id) {
        val = true;
      }
    }
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchManager>(
      builder: (context, watchManager, child) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Watch'),
        ),
        child: ListView(
          cacheExtent: 1000,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayer(
                  videoLink:
                      widget._episodes[watchManager.currentEpNumber].epLink,
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  widget._movie.mvName,
                ),
              ),
            ),
            const SizedBox(
                child: Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0, right: 8, left: 8),
              child: Text('Description:',
              style: TextStyle(fontSize: 14),),
            )),
            if (context.read<AuthManager>().user != null)
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<FavoriteManager>(
                    builder: (context, favoriteManager, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isFavorite(favoriteManager.favoriteMovies)
                            ? GestureDetector(
                                onTap: () {
                                  favoriteManager.deleteFavorite(
                                      context.read<AuthManager>().token,
                                      widget._movie.id);
                                },
                                child: const Icon(
                                  color: Color.fromARGB(255, 255, 1, 1),
                                  size: 40,
                                  CupertinoIcons.heart_fill,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  favoriteManager.addFavorite(
                                      context.read<AuthManager>().token,
                                      widget._movie.id);
                                },
                                child: const Icon(
                                  size: 40,
                                  CupertinoIcons.heart,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            const Divider(),
            SizedBox(
              child: EpisodeList(
                  widget._episodes, widget.episodeNumber, widget._movie),
            )
          ],
        ),
      ),
    );
  }
}

class EpisodeList extends StatefulWidget {
  const EpisodeList(this._episodes, this.episodeNumber, this._movie,
      {super.key});

  final List<Episode> _episodes;
  final int episodeNumber;
  final Movie _movie;

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  late int currentEpisode;

  @override
  void initState() {
    currentEpisode = widget.episodeNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var episode in widget._episodes)
          Consumer<WatchManager>(
            builder: (context, watchManager, child) => GestureDetector(
              onTap: () {
                watchManager.currentEpNumber = episode.epNumber;
                setState(() {
                  currentEpisode = episode.epNumber;
                  context.read<HistoryManager>().addHistory(
                      context.read<AuthManager>().token,
                      widget._movie.id,
                      currentEpisode);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    SizedBox(
                      child: Image.network(
                        width: 160,
                        height: 90,
                        fit: BoxFit.cover,
                        '${dotenv.env['API_HOST']}/${episode.epImage}',
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          style: episode.epNumber == currentEpisode
                              ? const TextStyle(
                                  color: CupertinoColors.activeBlue,
                                  fontSize: 14,
                                )
                              : const TextStyle(
                                  fontSize: 14,
                                ),
                          'Ep ${episode.epNumber} - ${episode.epName}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
