import 'package:flutter/cupertino.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('History'),
      ),
      child: ListView(
        children: const [
          HistoryList(
              episodes: ['episodes', 'episodes', 'episodes', 'episodes'])
        ],
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({
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
