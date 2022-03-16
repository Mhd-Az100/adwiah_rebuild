// To parse this JSON data, do
//
//     final medicalCenters = medicalCentersFromJson(jsonString);

import 'dart:convert';

List<MedicalCentersModel> medicalCentersFromJson(String str) =>
    List<MedicalCentersModel>.from(
        json.decode(str).map((x) => MedicalCentersModel.fromJson(x)));

String medicalCentersToJson(List<MedicalCentersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MedicalCentersModel {
  MedicalCentersModel({
    this.id,
    this.centerName,
    this.centerUrl,
    this.myorder,
  });

  int? id;
  String? centerName;
  String? centerUrl;
  int? myorder;

  factory MedicalCentersModel.fromJson(Map<String, dynamic> json) =>
      MedicalCentersModel(
        id: json["id"],
        centerName: json["center_name"],
        centerUrl: json["center_url"],
        myorder: json["myorder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "center_name": centerName,
        "center_url": centerUrl,
        "myorder": myorder,
      };
}
