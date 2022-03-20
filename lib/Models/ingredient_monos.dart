// To parse this JSON data, do
//
//     final ingredientMonosModel = ingredientMonosModelFromJson(jsonString);

import 'dart:convert';

List<IngredientMonosModel> ingredientMonosModelFromJson(String str) =>
    List<IngredientMonosModel>.from(
        json.decode(str).map((x) => IngredientMonosModel.fromJson(x)));

String ingredientMonosModelToJson(List<IngredientMonosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IngredientMonosModel {
  IngredientMonosModel({
    this.id,
    this.name,
    this.isHerbal,
    this.ingSynonyms,
    this.atc,
  });

  int? id;
  String? name;
  bool? isHerbal;
  String? ingSynonyms;
  String? atc;

  factory IngredientMonosModel.fromJson(Map<String, dynamic> json) =>
      IngredientMonosModel(
        id: json["ID"],
        name: json["Name"],
        isHerbal: json["IsHerbal"],
        ingSynonyms: json["Ing_Synonyms"],
        atc: json["ATC"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "IsHerbal": isHerbal,
        "Ing_Synonyms": ingSynonyms,
        "ATC": atc,
      };
}
