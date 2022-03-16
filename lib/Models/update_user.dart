// To parse this JSON data, do
//
//     final updatUserModel = updatUserModelFromJson(jsonString);

import 'dart:convert';

UpdatUserModel updatUserModelFromJson(String str) =>
    UpdatUserModel.fromJson(json.decode(str));

String updatUserModelToJson(UpdatUserModel data) => json.encode(data.toJson());

class UpdatUserModel {
  UpdatUserModel({
    this.id,
    this.userGuidId,
    this.userName,
    this.password,
    this.roleId,
    this.status,
    this.email,
    this.fName,
    this.lName,
    this.imei,
    this.mob,
    this.gender,
    this.accType,
    this.dtCreated,
    this.dtUpdate,
    this.block,
    this.activityNo,
    this.proffisionName,
    this.imageUrl,
    this.code,
  });

  int? id;
  String? userGuidId;
  dynamic userName;
  String? password;
  int? roleId;
  int? status;
  String? email;
  String? fName;
  String? lName;
  String? imei;
  String? mob;
  dynamic gender;
  int? accType;
  DateTime? dtCreated;
  dynamic dtUpdate;
  bool? block;
  int? activityNo;
  String? proffisionName;
  String? imageUrl;
  dynamic code;

  factory UpdatUserModel.fromJson(Map<String, dynamic> json) => UpdatUserModel(
        id: json["id"],
        userGuidId: json["user_guid_id"],
        userName: json["userName"],
        password: json["password"],
        roleId: json["Role_id"],
        status: json["status"],
        email: json["email"],
        fName: json["f_name"],
        lName: json["l_name"],
        imei: json["imei"],
        mob: json["mob"],
        gender: json["gender"],
        accType: json["acc_type"],
        dtCreated: DateTime.parse(json["dt_Created"]),
        dtUpdate: json["dt_Update"],
        block: json["block"],
        activityNo: json["activity_no"],
        proffisionName: json["proffision_name"],
        imageUrl: json["image_url"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_guid_id": userGuidId,
        "userName": userName,
        "password": password,
        "Role_id": roleId,
        "status": status,
        "email": email,
        "f_name": fName,
        "l_name": lName,
        "imei": imei,
        "mob": mob,
        "gender": gender,
        "acc_type": accType,
        "dt_Created": dtCreated?.toIso8601String(),
        "dt_Update": dtUpdate,
        "block": block,
        "activity_no": activityNo,
        "proffision_name": proffisionName,
        "image_url": imageUrl,
        "code": code,
      };
}
