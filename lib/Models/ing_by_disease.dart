// To parse this JSON data, do
//
//     final ingByDisease = ingByDiseaseFromJson(jsonString);

import 'dart:convert';

List<IngByDiseaseModel> ingByDiseaseFromJson(String str) =>
    List<IngByDiseaseModel>.from(
        json.decode(str).map((x) => IngByDiseaseModel.fromJson(x)));

String ingByDiseaseToJson(List<IngByDiseaseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IngByDiseaseModel {
  IngByDiseaseModel({
    this.id,
    this.name,
    this.isHerbal,
    this.ingSynonyms,
    this.atc,
  });

  int? id;
  String? name;
  dynamic? isHerbal;
  String? ingSynonyms;
  dynamic? atc;

  factory IngByDiseaseModel.fromJson(Map<String, dynamic> json) =>
      IngByDiseaseModel(
        id: json["ID"],
        name: json["Name"],
        isHerbal: json["IsHerbal"] ?? '',
        ingSynonyms: json["Ing_Synonyms"],
        atc: json["ATC"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "IsHerbal": isHerbal,
        "Ing_Synonyms": ingSynonyms,
        "ATC": atc,
      };
}
