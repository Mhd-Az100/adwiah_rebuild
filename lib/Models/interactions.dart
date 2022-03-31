// To parse this JSON data, do
//
//     final InteractionModel = dosageFromJson(jsonString);

import 'dart:convert';

List<InteractionModel> InteractionModelFromJson(String str) =>
    List<InteractionModel>.from(
        json.decode(str).map((x) => InteractionModel.fromJson(x)));

String InteractionModelToJson(List<InteractionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InteractionModel {
  InteractionModel({
    this.ingBName,
    this.interactionId,
    this.ingAName,
    this.severityLevelId,
    this.fullIngbName,
  });

  String? ingBName;
  int? interactionId;
  String? ingAName;
  int? severityLevelId;
  dynamic fullIngbName;

  factory InteractionModel.fromJson(Map<String, dynamic> json) =>
      InteractionModel(
        ingBName: json["IngB_Name"],
        interactionId: json["Interaction_ID"],
        ingAName: json["IngA_Name"],
        severityLevelId: json["Severity_Level_ID"],
        fullIngbName: json["_full_Ingb_Name"],
      );

  Map<String, dynamic> toJson() => {
        "IngB_Name": ingBName,
        "Interaction_ID": interactionId,
        "IngA_Name": ingAName,
        "Severity_Level_ID": severityLevelId,
        "_full_Ingb_Name": fullIngbName,
      };
}
