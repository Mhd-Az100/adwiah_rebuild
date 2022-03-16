// To parse this JSON data, do
//
//     final iconsList = iconsListFromJson(jsonString);

import 'dart:convert';

List<IconsListModel> iconsListFromJson(String str) => List<IconsListModel>.from(
    json.decode(str).map((x) => IconsListModel.fromJson(x)));

String iconsListToJson(List<IconsListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IconsListModel {
  IconsListModel({
    this.id,
    this.iconNameEn,
    this.iconNameAr,
    this.iconUrl,
  });

  int? id;
  String? iconNameEn;
  String? iconNameAr;
  String? iconUrl;

  factory IconsListModel.fromJson(Map<String, dynamic> json) => IconsListModel(
        id: json["id"],
        iconNameEn: json["icon_name_en"],
        iconNameAr: json["icon_name_ar"],
        iconUrl: json["icon_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "icon_name_en": iconNameEn,
        "icon_name_ar": iconNameAr,
        "icon_url": iconUrl,
      };
}
