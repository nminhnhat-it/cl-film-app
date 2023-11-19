import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/me/history_manager.dart';
import 'package:ct484_project/ui/watch/watch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    context
        .read<HistoryManager>()
        .fetchHistory(context.read<AuthManager>().token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryManager>(
      builder: (context, historyManager, child) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('History'),
        ),
        child: ListView(
          children: [
              HistoryList(historyManager.history),
          ],
        ),
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList(this.movies, {super.key});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var movie in movies)
           if(movie.episodes.isNotEmpty) GestureDetector(
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                builder: (BuildContext context) => WatchScreen(
                  movie,
                  movie.episodes,
                  movie.epNumber,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  SizedBox(
                    child: Image.network(
                      width: 160,
                      height: 90,
                      fit: BoxFit.cover,
                      '${dotenv.env['API_HOST']}/${movie.episodes[movie.epNumber-1].epImage}',
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        style: const TextStyle(fontSize: 20),
                        "Ep ${movie.epNumber} - ${movie.episodes[movie.epNumber-1].epName}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
