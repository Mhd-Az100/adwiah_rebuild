// To parse this JSON data, do
//
//     final countriesModel = countriesModelFromJson(jsonString);

import 'dart:convert';

List<CountriesModel> countriesModelFromJson(String str) =>
    List<CountriesModel>.from(
        json.decode(str).map((x) => CountriesModel.fromJson(x)));

String countriesModelToJson(List<CountriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountriesModel {
  CountriesModel({
    this.countryId,
    this.country,
    this.countryAr,
    this.type,
    this.active,
  });

  int? countryId;
  String? country;
  String? countryAr;
  int? type;
  bool? active;

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
        countryId: json["Country_ID"],
        country: json["Country"],
        countryAr: json["Country_AR"] == null ? null : json["Country_AR"],
        type: json["TYPE"],
        active: json["Active"],
      );

  Map<String, dynamic> toJson() => {
        "Country_ID": countryId,
        "Country": country,
        "Country_AR": countryAr == null ? null : countryAr,
        "TYPE": type,
        "Active": active,
      };
}
