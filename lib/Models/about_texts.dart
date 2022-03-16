// To parse this JSON data, do
//
//     final aboutTextModel = aboutTextModelFromJson(jsonString);

import 'dart:convert';

List<AboutTextModel> aboutTextModelFromJson(String str) =>
    List<AboutTextModel>.from(
        json.decode(str).map((x) => AboutTextModel.fromJson(x)));

String aboutTextModelToJson(List<AboutTextModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AboutTextModel {
  AboutTextModel({
    this.id,
    this.titleAr,
    this.textAr,
    this.titleEn,
    this.textEn,
    this.titleFr,
    this.textFr,
  });

  int? id;
  String? titleAr;
  String? textAr;
  String? titleEn;
  String? textEn;
  String? titleFr;
  String? textFr;

  factory AboutTextModel.fromJson(Map<String, dynamic> json) => AboutTextModel(
        id: json["id"],
        titleAr: json["title_ar"],
        textAr: json["text_ar"],
        titleEn: json["title_en"],
        textEn: json["text_en"],
        titleFr: json["title_fr"] == null ? null : json["title_fr"],
        textFr: json["text_fr"] == null ? null : json["text_fr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_ar": titleAr,
        "text_ar": textAr,
        "title_en": titleEn,
        "text_en": textEn,
        "title_fr": titleFr == null ? null : titleFr,
        "text_fr": textFr == null ? null : textFr,
      };
}
