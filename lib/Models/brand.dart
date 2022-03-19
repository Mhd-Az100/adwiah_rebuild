// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

List<BrandModel> brandModelFromJson(String str) =>
    List<BrandModel>.from(json.decode(str).map((x) => BrandModel.fromJson(x)));

String brandModelToJson(List<BrandModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandModel {
  BrandModel({
    this.brandId,
    this.ingId,
    this.brandName,
    this.duple,
    this.route,
    this.duple2,
  });

  int? brandId;
  int? ingId;
  String? brandName;
  int? duple;
  String? route;
  int? duple2;

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        brandId: json["Brand_ID"],
        ingId: json["Ing_ID"],
        brandName: json["Brand_Name"],
        duple: json["duple"],
        route: json["Route"],
        duple2: json["duple2"],
      );

  Map<String, dynamic> toJson() => {
        "Brand_ID": brandId,
        "Ing_ID": ingId,
        "Brand_Name": brandName,
        "duple": duple,
        "Route": route,
        "duple2": duple2,
      };
}
