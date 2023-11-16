import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './video_player.dart';

class WatchScreen extends StatelessWidget {
  final String videoLink;

  const WatchScreen({
    super.key,
    required this.videoLink,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
                videoLink: videoLink,
              ),
            ),
          ),
          const SizedBox(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                'Movie Name',
              ),
            ),
          ),
          const SizedBox(
              child: Padding(
            padding: EdgeInsets.only(top: 0, bottom: 0, right: 8, left: 8),
            child: Text('Description:'),
          )),
          const SizedBox(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon(
                  //   size: 40,
                  //   CupertinoIcons.heart,
                  // ),
                  Icon(
                    color: Color.fromARGB(255, 255, 1, 1),
                    size: 40,
                    CupertinoIcons.heart_fill,
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          const SizedBox(
            child: EpisodeList(
              episodes: ['ep1', 'ep2', 'ep3', 'ep4'],
            ),
          )
        ],
      ),
    );
  }
}

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    super.key,
    required this.episodes,
  });

  final List<String> episodes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var episode in episodes)
          Padding(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    style: const TextStyle(fontSize: 20),
                    episode,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
