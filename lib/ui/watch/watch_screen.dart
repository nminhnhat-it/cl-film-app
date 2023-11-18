import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/ui/watch/watch_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './video_player.dart';

class WatchScreen extends StatelessWidget {
  final Movie _movie;
  final List<Episode> _episodes;
  final int episodeNumber;

  const WatchScreen(this._movie, this._episodes, this.episodeNumber,
      {super.key});

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
                  videoLink: _episodes[watchManager.currentEpNumber].epLink,
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  _movie.mvName,
                ),
              ),
            ),
            const SizedBox(
                child: Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0, right: 8, left: 8),
              child: Text('Description:'),
            )),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !_movie.isFavorite
                        ? const Icon(
                            size: 40,
                            CupertinoIcons.heart,
                          )
                        : const Icon(
                            color: Color.fromARGB(255, 255, 1, 1),
                            size: 40,
                            CupertinoIcons.heart_fill,
                          ),
                  ],
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              child: EpisodeList(_episodes, episodeNumber),
            )
          ],
        ),
      ),
    );
  }
}

class EpisodeList extends StatefulWidget {
  const EpisodeList(this._episodes, this.episodeNumber, {super.key});

  final List<Episode> _episodes;
  final int episodeNumber;

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
                        'http://localhost:3000/public/uploads/sndyf24n24m.png',
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          style: episode.epNumber == currentEpisode
                              ? const TextStyle(
                                  color: CupertinoColors.activeBlue,
                                  fontSize: 20,
                                )
                              : const TextStyle(
                                  fontSize: 20,
                                ),
                          'Ep ${episode.epNumber} - ${episode.epName}',
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
