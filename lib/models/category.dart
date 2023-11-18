import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  String id;
  String kName;

  Category({
    required this.id,
    required this.kName,
  });

  factory Category.fromJson(Map<dynamic, dynamic> json) => Category(
        id: json["_id"],
        kName: json["k_name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "_id": id,
        "k_name": kName,
      };
}
