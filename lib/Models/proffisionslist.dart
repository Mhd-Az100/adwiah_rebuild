// To parse this JSON data, do
//
//     final proffisionslist = proffisionslistFromJson(jsonString);

import 'dart:convert';

List<Proffisionslist> proffisionslistFromJson(String str) =>
    List<Proffisionslist>.from(
        json.decode(str).map((x) => Proffisionslist.fromJson(x)));

String proffisionslistToJson(List<Proffisionslist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Proffisionslist {
  Proffisionslist({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Proffisionslist.fromJson(Map<String, dynamic> json) =>
      Proffisionslist(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
