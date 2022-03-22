// To parse this JSON data, do
//
//     final studyInteractionsModel = studyInteractionsModelFromJson(jsonString);

import 'dart:convert';

List<StudyInteractionsModel> studyInteractionsModelFromJson(String str) =>
    List<StudyInteractionsModel>.from(
        json.decode(str).map((x) => StudyInteractionsModel.fromJson(x)));

String studyInteractionsModelToJson(List<StudyInteractionsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudyInteractionsModel {
  StudyInteractionsModel({
    this.interactionId,
    this.ingAName,
    this.ingBName,
    this.ingBWithName,
    this.duration,
    this.severityLevel,
    this.interActionType,
    this.recommendationText,
    this.moreInfoText,
    this.refs,
    this.note,
    this.nointeraction,
  });

  int? interactionId;
  String? ingAName;
  String? ingBName;
  dynamic? ingBWithName;
  dynamic? duration;
  String? severityLevel;
  String? interActionType;
  String? recommendationText;
  String? moreInfoText;
  String? refs;
  String? note;
  dynamic? nointeraction;

  factory StudyInteractionsModel.fromJson(Map<String, dynamic> json) =>
      StudyInteractionsModel(
        interactionId: json["Interaction_ID"],
        ingAName: json["IngA_name"],
        ingBName: json["IngB_name"],
        ingBWithName: json["IngBWith_name"],
        duration: json["Duration"],
        severityLevel: json["Severity_Level"],
        interActionType: json["InterActionType"],
        recommendationText: json["Recommendation_text"] == null
            ? null
            : json["Recommendation_text"],
        moreInfoText:
            json["More_Info_text"] == null ? null : json["More_Info_text"],
        refs: json["refs"],
        note: json["note"],
        nointeraction: json["nointeraction"],
      );

  Map<String, dynamic> toJson() => {
        "Interaction_ID": interactionId,
        "IngA_name": ingAName,
        "IngB_name": ingBName,
        "IngBWith_name": ingBWithName,
        "Duration": duration,
        "Severity_Level": severityLevel,
        "InterActionType": interActionType,
        "Recommendation_text":
            recommendationText == null ? null : recommendationText,
        "More_Info_text": moreInfoText == null ? null : moreInfoText,
        "refs": refs,
        "note": note,
        "nointeraction": nointeraction,
      };
}
