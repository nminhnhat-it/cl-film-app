import 'package:ct484_project/models/movie.dart';
import 'package:ct484_project/ui/home/home_manager.dart';
import 'package:ct484_project/ui/watch/watch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Movie> _movies;
  List<Movie> _resMovies = [];
  String _searchWord = "";

  void filterSearch(newValue) {
    setState(() {
      _searchWord = newValue;
      if (_searchWord != "") {
        _resMovies = _movies
            .where((movie) =>
                movie.mvName.toLowerCase().contains(_searchWord.toLowerCase()))
            .toList();
      } else {
        _resMovies = [];
      }
    });
  }

  @override
  void initState() {
    _movies = context.read<HomeManager>().movies;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Search')),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            child: ListView(
                children: [if (_resMovies.isNotEmpty) SearchList(_resMovies)]),
          ),
          Container(
            height: 50,
            color: CupertinoColors.secondarySystemBackground,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(top: 100),
            child: CupertinoTextFormFieldRow(
              prefix: const Icon(CupertinoIcons.search),
              onChanged: (value) {
                filterSearch(value);
              },
              placeholder: "Enter movie name",
            ),
          ),
        ],
      ),
    );
  }
}

class SearchList extends StatelessWidget {
  const SearchList(this.movies, {super.key});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var movie in movies)
          GestureDetector(
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                builder: (BuildContext context) => WatchScreen(
                  movie,
                  movie.episodes,
                  1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  if (movie.episodes.isNotEmpty)
                    SizedBox(
                      child: Image.network(
                        width: 160,
                        height: 90,
                        fit: BoxFit.cover,
                        '${dotenv.env['API_HOST']}/${movie.episodes[0].epImage}',
                      ),
                    ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        style: const TextStyle(fontSize: 20),
                        movie.mvName,
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
