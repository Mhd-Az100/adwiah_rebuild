// To parse this JSON data, do
//
//     final LocationsPharma = LocationsPharmaFromJson(jsonString);

import 'dart:convert';

List<LocationsPharmaModel> LocationsPharmaFromJson(String str) =>
    List<LocationsPharmaModel>.from(
        json.decode(str).map((x) => LocationsPharmaModel.fromJson(x)));

String LocationsPharmaToJson(List<LocationsPharmaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationsPharmaModel {
  LocationsPharmaModel({
    this.id,
    this.phnamear,
    this.phnameen,
    this.loc1,
    this.loc2,
    this.loc3,
    this.loc,
    this.lat,
    this.lon,
    this.tel,
    this.web,
    this.more1,
    this.more2,
    this.more3,
    this.more4,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? phnamear;
  String? phnameen;
  String? loc1;
  String? loc2;
  String? loc3;
  String? loc;
  String? lat;
  String? lon;
  String? tel;
  String? web;
  String? more1;
  String? more2;
  String? more3;
  String? more4;
  String? createdAt;
  DateTime? updatedAt;

  factory LocationsPharmaModel.fromJson(Map<String, dynamic> json) =>
      LocationsPharmaModel(
        id: json["id"],
        phnamear: json["phnamear"],
        phnameen: json["phnameen"],
        loc1: json["loc1"],
        loc2: json["loc2"],
        loc3: json["loc3"],
        loc: json["loc"],
        lat: json["lat"],
        lon: json["lon"],
        tel: json["tel"],
        web: json["web"],
        more1: json["more1"],
        more2: json["more2"],
        more3: json["more3"],
        more4: json["more4"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phnamear": phnamear,
        "phnameen": phnameen,
        "loc1": loc1,
        "loc2": loc2,
        "loc3": loc3,
        "loc": loc,
        "lat": lat,
        "lon": lon,
        "tel": tel,
        "web": web,
        "more1": more1,
        "more2": more2,
        "more3": more3,
        "more4": more4,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
