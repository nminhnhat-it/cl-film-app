class Episode {
  String id;
  String epLink;
  int epNumber;
  String epName;
  String epImage;
  String mvId;

  Episode({
    required this.id,
    required this.epLink,
    required this.epNumber,
    required this.epName,
    required this.epImage,
    required this.mvId,
  });

  factory Episode.fromJson(Map<dynamic, dynamic> json) => Episode(
        id: json["_id"],
        epLink: json["ep_link"],
        epNumber: json["ep_number"],
        epName: json["ep_name"],
        epImage: json["ep_image"],
        mvId: json["mv_id"],
      );

  Map<dynamic, dynamic> toJson() => {
        "_id": id,
        "ep_link": epLink,
        "ep_number": epNumber,
        "ep_name": epName,
        "ep_image": epImage,
        "mv_id": mvId,
      };
}
