// To parse this JSON data, do
//
//     final similarDiseaseModel = similarDiseaseModelFromJson(jsonString);

import 'dart:convert';

List<SimilarDiseaseModel> similarDiseaseModelFromJson(String str) =>
    List<SimilarDiseaseModel>.from(
        json.decode(str).map((x) => SimilarDiseaseModel.fromJson(x)));

String similarDiseaseModelToJson(List<SimilarDiseaseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SimilarDiseaseModel {
  SimilarDiseaseModel({
    this.groupId,
    this.groupName,
    this.keyId,
    this.diseaseName,
    this.diseaseNamesAr,
    this.groupArabicName,
  });

  int? groupId;
  String? groupName;
  String? keyId;
  String? diseaseName;
  String? diseaseNamesAr;
  String? groupArabicName;

  factory SimilarDiseaseModel.fromJson(Map<String, dynamic> json) =>
      SimilarDiseaseModel(
        groupId: json["group_id"],
        groupName: json["GroupName"].toString().replaceAll(';', ''),
        keyId: json["KeyId"].toString().replaceAll(';', ''),
        diseaseName: json["DiseaseName"].toString().replaceAll(';', ''),
        diseaseNamesAr: json["DiseaseNames_ar"].toString().replaceAll(';', ''),
        groupArabicName: json["groupArabicName"].toString().replaceAll(';', ''),
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "GroupName": groupName,
        "KeyId": keyId,
        "DiseaseName": diseaseName,
        "DiseaseNames_ar": diseaseNamesAr,
        "groupArabicName": groupArabicName,
      };
}
