import 'dart:convert';

import 'package:ct484_project/models/episode.dart';

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
  dynamic epNumber;
  List<Episode> episodes;

  Movie({
    required this.id,
    required this.mvName,
    required this.mvDesc,
    required this.mvEpisode,
    required this.mvImage,
    this.epNumber,
    required this.episodes,
  });

  factory Movie.fromJson(Map<dynamic, dynamic> json) => Movie(
        id: json["_id"],
        mvName: json["mv_name"],
        mvDesc: json["mv_desc"],
        mvEpisode: json["mv_episode"],
        mvImage: json["mv_image"],
        epNumber: json["ep_number"],
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "_id": id,
        "mv_name": mvName,
        "mv_desc": mvDesc,
        "mv_episode": mvEpisode,
        "mv_image": mvImage,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };
}