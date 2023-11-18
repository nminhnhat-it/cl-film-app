import 'dart:convert';

List<Movie> movieFromJson(String str) =>
    List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
  String id;
  String mvName;
  String mvDesc;
  int mvEpisode;
  String mvImage;
  bool isFavorite;
  List<Episode> episodes;

  Movie({
    required this.id,
    required this.mvName,
    required this.mvDesc,
    required this.mvEpisode,
    required this.mvImage,
    required this.isFavorite,
    required this.episodes,
  });

  factory Movie.fromJson(Map<dynamic, dynamic> json) => Movie(
        id: json["_id"],
        mvName: json["mv_name"],
        mvDesc: json["mv_desc"],
        mvEpisode: json["mv_episode"],
        mvImage: json["mv_image"],
        isFavorite: json["isFavorite"],
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "_id": id,
        "mv_name": mvName,
        "mv_desc": mvDesc,
        "mv_episode": mvEpisode,
        "mv_image": mvImage,
        "isFavorite": isFavorite,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };
}

class Episode {
  String id;
  String epLink;
  int epNumber;
  String epName;
  String mvId;

  Episode({
    required this.id,
    required this.epLink,
    required this.epNumber,
    required this.epName,
    required this.mvId,
  });

  factory Episode.fromJson(Map<dynamic, dynamic> json) => Episode(
        id: json["_id"],
        epLink: json["ep_link"],
        epNumber: json["ep_number"],
        epName: json["ep_name"],
        mvId: json["mv_id"],
      );

  Map<dynamic, dynamic> toJson() => {
        "_id": id,
        "ep_link": epLink,
        "ep_number": epNumber,
        "ep_name": epName,
        "mv_id": mvId,
      };
}
