// To parse this JSON data, do
//
//     final ingTherapeuticModel = ingTherapeuticModelFromJson(jsonString);

import 'dart:convert';

List<IngTherapeuticModel> ingTherapeuticModelFromJson(String str) =>
    List<IngTherapeuticModel>.from(
        json.decode(str).map((x) => IngTherapeuticModel.fromJson(x)));

String ingTherapeuticModelToJson(List<IngTherapeuticModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IngTherapeuticModel {
  IngTherapeuticModel({
    this.theId,
    this.name,
    this.atc,
    this.ingId,
    this.motherName,
    this.motherAtc,
  });

  int? theId;
  String? name;
  String? atc;
  int? ingId;
  String? motherName;
  String? motherAtc;

  factory IngTherapeuticModel.fromJson(Map<String, dynamic> json) =>
      IngTherapeuticModel(
        theId: json["The_ID"],
        name: json["Name"],
        atc: json["ATC"],
        ingId: json["Ing_ID"],
        motherName: json["Mother_Name"],
        motherAtc: json["Mother_ATC"],
      );

  Map<String, dynamic> toJson() => {
        "The_ID": theId,
        "Name": name,
        "ATC": atc,
        "Ing_ID": ingId,
        "Mother_Name": motherName,
        "Mother_ATC": motherAtc,
      };
}
