// To parse this JSON data, do
//
//     final indicationsModel = indicationsModelFromJson(jsonString);

import 'dart:convert';

List<IndicationsModel> indicationsModelFromJson(String str) =>
    List<IndicationsModel>.from(
        json.decode(str).map((x) => IndicationsModel.fromJson(x)));

String indicationsModelToJson(List<IndicationsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IndicationsModel {
  IndicationsModel({
    this.id,
    this.valEn,
    this.valAr,
    this.explanation,
    this.explanationAr,
  });

  int? id;
  String? valEn;
  String? valAr;
  String? explanation;
  String? explanationAr;

  factory IndicationsModel.fromJson(Map<String, dynamic> json) =>
      IndicationsModel(
        id: json["ID"],
        valEn: json["Val_en"],
        valAr: json["Val_ar"],
        explanation: json["Explanation"],
        explanationAr: json["Explanation_ar"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Val_en": valEn,
        "Val_ar": valAr,
        "Explanation": explanation,
        "Explanation_ar": explanationAr,
      };
}
