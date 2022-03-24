// To parse this JSON data, do
//
//     final diseaseModel = diseaseModelFromJson(jsonString);

import 'dart:convert';

List<DiseaseModel> diseaseModelFromJson(String str) => List<DiseaseModel>.from(
    json.decode(str).map((x) => DiseaseModel.fromJson(x)));

String diseaseModelToJson(List<DiseaseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DiseaseModel {
  DiseaseModel({
    this.id,
    this.valEn,
    this.valAr,
    this.explanation,
    this.explanationAr,
  });

  int? id;
  String? valEn;
  String? valAr;
  dynamic? explanation;
  dynamic? explanationAr;

  factory DiseaseModel.fromJson(Map<String, dynamic> json) => DiseaseModel(
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
