// To parse this JSON data, do
//
//     final versionListModel = versionListModelFromJson(jsonString);

import 'dart:convert';

List<VersionListModel> versionListModelFromJson(String str) =>
    List<VersionListModel>.from(
        json.decode(str).map((x) => VersionListModel.fromJson(x)));

String versionListModelToJson(List<VersionListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VersionListModel {
  VersionListModel({
    this.id,
    this.listname,
    this.version,
    this.updateDate,
    this.countryId,
  });

  int? id;
  String? listname;
  String? version;
  DateTime? updateDate;
  int? countryId;

  factory VersionListModel.fromJson(Map<String, dynamic> json) =>
      VersionListModel(
        id: json["id"],
        listname: json["listname"],
        version: json["version"],
        updateDate: DateTime.parse(json["updateDate"]),
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "listname": listname,
        "version": version,
        "updateDate": updateDate?.toIso8601String(),
        "country_id": countryId,
      };
}
