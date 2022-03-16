// To parse this JSON data, do
//
//     final postsModel = postsModelFromJson(jsonString);

import 'dart:convert';

List<PostsModel> postsModelFromJson(String str) =>
    List<PostsModel>.from(json.decode(str).map((x) => PostsModel.fromJson(x)));

String postsModelToJson(List<PostsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostsModel {
  PostsModel({
    this.id,
    this.title,
    this.shortDescription,
    this.description,
    this.postDate,
    this.publishStart,
    this.publishEnd,
    this.imageUrl,
    this.countryId,
    this.lang,
  });

  int? id;
  String? title;
  String? shortDescription;
  String? description;
  DateTime? postDate;
  DateTime? publishStart;
  DateTime? publishEnd;
  String? imageUrl;
  dynamic? countryId;
  String? lang;

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        id: json["id"],
        title: json["title"],
        shortDescription: json["short_description"],
        description: json["description"],
        postDate: DateTime.parse(json["post_date"]),
        publishStart: DateTime.parse(json["publish_start"]),
        publishEnd: DateTime.parse(json["publish_end"]),
        imageUrl: json["image_url"],
        countryId: json["country_id"],
        lang: json["lang"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "short_description": shortDescription,
        "description": description,
        "post_date": postDate?.toIso8601String(),
        "publish_start": publishStart?.toIso8601String(),
        "publish_end": publishEnd?.toIso8601String(),
        "image_url": imageUrl,
        "country_id": countryId,
        "lang": lang,
      };
}
