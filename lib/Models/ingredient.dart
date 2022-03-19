// To parse this JSON data, do
//
//     final ingredientModel = ingredientModelFromJson(jsonString);

import 'dart:convert';

List<IngredientModel> ingredientModelFromJson(String str) =>
    List<IngredientModel>.from(
        json.decode(str).map((x) => IngredientModel.fromJson(x)));

String ingredientModelToJson(List<IngredientModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IngredientModel {
  IngredientModel({
    this.id,
    this.name,
    this.atcId,
    this.type,
    this.duple,
    this.recType,
  });

  int? id;
  String? name;
  String? atcId;
  int? type;
  int? duple;
  int? recType;

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        id: json["ID"],
        name: json["Name"],
        atcId: json["AtcID"],
        type: json["Type"],
        duple: json["duple"],
        recType: json["Rec_Type"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "AtcID": atcId,
        "Type": type,
        "duple": duple,
        "Rec_Type": recType,
      };
}
