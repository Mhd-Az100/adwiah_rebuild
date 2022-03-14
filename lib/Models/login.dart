// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.message,
    this.success,
    this.userGuidId,
    this.email,
    this.fName,
    this.lName,
    this.accType,
    this.mob,
    this.imei,
    this.block,
    this.proffisionName,
    this.imageUrl,
    this.status,
  });

  String? message;
  bool? success;
  String? userGuidId;
  String? email;
  String? fName;
  String? lName;
  int? accType;
  String? mob;
  String? imei;
  bool? block;
  dynamic? proffisionName;
  dynamic? imageUrl;
  int? status;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        success: json["success"],
        userGuidId: json["user_guid_id"],
        email: json["email"],
        fName: json["f_name"],
        lName: json["l_name"],
        accType: json["acc_type"],
        mob: json["mob"],
        imei: json["imei"],
        block: json["block"],
        proffisionName: json["proffision_name"],
        imageUrl: json["image_url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "user_guid_id": userGuidId,
        "email": email,
        "f_name": fName,
        "l_name": lName,
        "acc_type": accType,
        "mob": mob,
        "imei": imei,
        "block": block,
        "proffision_name": proffisionName,
        "image_url": imageUrl,
        "status": status,
      };
}
