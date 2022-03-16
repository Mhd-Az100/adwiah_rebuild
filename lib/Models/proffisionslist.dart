// To parse this JSON data, do
//
//     final proffisionslist = proffisionslistFromJson(jsonString);

import 'dart:convert';

List<ProffisionslistModel> proffisionslistFromJson(String str) =>
    List<ProffisionslistModel>.from(
        json.decode(str).map((x) => ProffisionslistModel.fromJson(x)));

String proffisionslistToJson(List<ProffisionslistModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProffisionslistModel {
  ProffisionslistModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory ProffisionslistModel.fromJson(Map<String, dynamic> json) =>
      ProffisionslistModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
