// To parse this JSON data, do
//
//     final brandByIdModel = brandByIdModelFromJson(jsonString);

import 'dart:convert';

List<BrandByIdModel> brandByIdModelFromJson(String str) =>
    List<BrandByIdModel>.from(
        json.decode(str).map((x) => BrandByIdModel.fromJson(x)));

String brandByIdModelToJson(List<BrandByIdModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandByIdModel {
  BrandByIdModel({
    this.brandId,
    this.ingId,
    this.compositionId,
    this.brandName,
    this.bg,
    this.nssfRate,
    this.route,
    this.routeAr,
    this.families,
    this.pharmaceuticalForm,
    this.pharmaceuticalFormAr,
    this.compositionText,
    this.authorizationId,
    this.mohAuthorizationNumber,
    this.mohAuthorizationDate,
    this.agentId,
    this.agent,
    this.lic,
    this.licId,
    this.labId,
    this.lab,
    this.price,
    this.isherbal,
    this.dosageForm,
    this.dosageFormAr,
    this.sgender,
    this.sgenderAr,
    this.nssf,
    this.otc,
    this.gender,
    this.ean13BarcodeId,
    this.alternativeBrands,
    this.icon,
    this.caliberAr,
    this.caliberEn,
    this.importerAgentAr,
    this.importerAgentEn,
    this.lastUpdateDate,
  });

  int? brandId;
  int? ingId;
  int? compositionId;
  String? brandName;
  String? bg;
  dynamic nssfRate;
  String? route;
  String? routeAr;
  String? families;
  String? pharmaceuticalForm;
  String? pharmaceuticalFormAr;
  String? compositionText;
  int? authorizationId;
  String? mohAuthorizationNumber;
  dynamic mohAuthorizationDate;
  dynamic agentId;
  String? agent;
  dynamic lic;
  dynamic licId;
  dynamic labId;
  String? lab;
  String? price;
  bool? isherbal;
  String? dosageForm;
  String? dosageFormAr;
  String? sgender;
  String? sgenderAr;
  String? nssf;
  bool? otc;
  dynamic gender;
  String? ean13BarcodeId;
  dynamic alternativeBrands;
  int? icon;
  String? caliberAr;
  String? caliberEn;
  String? importerAgentAr;
  String? importerAgentEn;
  String? lastUpdateDate;

  factory BrandByIdModel.fromJson(Map<String, dynamic> json) => BrandByIdModel(
        brandId: json["Brand_ID"],
        ingId: json["Ing_ID"],
        compositionId: json["CompositionID"],
        brandName: json["Brand_Name"],
        bg: json["BG"],
        nssfRate: json["nssf_rate"],
        route: json["Route"],
        routeAr: json["Route_ar"],
        families: json["families"],
        pharmaceuticalForm: json["Pharmaceutical_Form"],
        pharmaceuticalFormAr: json["Pharmaceutical_Form_ar"],
        compositionText: json["composition_text"],
        authorizationId: json["Authorization_ID"],
        mohAuthorizationNumber: json["MOH_Authorization_Number"],
        mohAuthorizationDate: json["MOH_Authorization_Date"],
        agentId: json["agent_id"],
        agent: json["agent"],
        lic: json["Lic"],
        licId: json["Lic_id"],
        labId: json["Lab_id"],
        lab: json["Lab"],
        price: json["Price"],
        isherbal: json["isherbal"],
        dosageForm: json["DosageForm"],
        dosageFormAr: json["DosageForm_ar"],
        sgender: json["Sgender"],
        sgenderAr: json["Sgender_ar"],
        nssf: json["nssf"],
        otc: json["otc"],
        gender: json["gender"],
        ean13BarcodeId: json["Ean_13_Barcode_ID"],
        alternativeBrands: json["Alternative_Brands"],
        icon: json["icon"],
        caliberAr: json["caliber_ar"],
        caliberEn: json["caliber_en"],
        importerAgentAr: json["importer_agent_ar"],
        importerAgentEn: json["importer_agent_en"],
        lastUpdateDate: json["last_update_date"],
      );

  Map<String, dynamic> toJson() => {
        "Brand_ID": brandId,
        "Ing_ID": ingId,
        "CompositionID": compositionId,
        "Brand_Name": brandName,
        "BG": bg,
        "nssf_rate": nssfRate,
        "Route": route,
        "Route_ar": routeAr,
        "families": families,
        "Pharmaceutical_Form": pharmaceuticalForm,
        "Pharmaceutical_Form_ar": pharmaceuticalFormAr,
        "composition_text": compositionText,
        "Authorization_ID": authorizationId,
        "MOH_Authorization_Number": mohAuthorizationNumber,
        "MOH_Authorization_Date": mohAuthorizationDate,
        "agent_id": agentId,
        "agent": agent,
        "Lic": lic,
        "Lic_id": licId,
        "Lab_id": labId,
        "Lab": lab,
        "Price": price,
        "isherbal": isherbal,
        "DosageForm": dosageForm,
        "DosageForm_ar": dosageFormAr,
        "Sgender": sgender,
        "Sgender_ar": sgenderAr,
        "nssf": nssf,
        "otc": otc,
        "gender": gender,
        "Ean_13_Barcode_ID": ean13BarcodeId,
        "Alternative_Brands": alternativeBrands,
        "icon": icon,
        "caliber_ar": caliberAr,
        "caliber_en": caliberEn,
        "importer_agent_ar": importerAgentAr,
        "importer_agent_en": importerAgentEn,
        "last_update_date": lastUpdateDate,
      };
}
