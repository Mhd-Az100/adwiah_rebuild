// ignore_for_file: prefer_const_declarations

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;
  List productName = [];

  static final DatabaseHelper? instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB('notes.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final idKeyType = 'INTEGER';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';

    await db.execute(
        '''
CREATE TABLE ${VisitModel.visitTable} (
  ${VisitModel.columnVisitId} $idType,
  ${VisitModel.columnDoctorName} $textType,
  ${VisitModel.columnDoctorSpec} $textType,
  ${VisitModel.columnAddress} $textType,
  ${VisitModel.columnPhoneNumber} $textType,
  ${VisitModel.columnDateTime} $textType,
  ${VisitModel.columnListImage} $textType,
  ${VisitModel.columnSymptoms} $textType,
  ${VisitModel.columnDiagnosis} $textType
  )
''');

    await db.execute(
        '''
CREATE TABLE ${PrescriptionModel.prescriptionTable} (
  ${PrescriptionModel.columnPrescriptionId} $idType,
  ${PrescriptionModel.columnPrescriptionDrugs} $textType,
  ${PrescriptionModel.columnPrescriptionImage} $textType,
  ${PrescriptionModel.columnPrescriptionVisitId} $idKeyType
  )
''');

    await db.execute(
        '''
CREATE TABLE ${DrugsModel.drugsTable} (
  ${DrugsModel.columnDrugsId} $idType,
  ${DrugsModel.columnDrugsName} $textType,
  ${DrugsModel.columnDrugsTakes} $textType,
  ${DrugsModel.columnDrugsDate} $textType,
  ${DrugsModel.columnDrugsTime} $textType,
  ${DrugsModel.columnDrugsDuration} $textType,
  ${DrugsModel.columnDrugsPrescriptionId} $idKeyType
  )
''');

    await db.execute(
        '''
CREATE TABLE ${NotificationModel.notificationTable} (
  ${NotificationModel.columnNotificationId} $idType,
  ${NotificationModel.columnNotificationTitle} $textType,
  ${NotificationModel.columnNotificationBody} $textType,
  ${NotificationModel.columnNotificationDate} $textType,
  ${NotificationModel.columnNotificationTime} $textType,
  ${NotificationModel.columnNotificationDrugsData} $textType,
  ${NotificationModel.columnNotificationDrugsID} $idKeyType,
  ${NotificationModel.columnNotificationStatus} $idKeyType
  )
''');

    await db.execute(
        '''
CREATE TABLE ${DoctorModel.doctorTable} (
  ${DoctorModel.columnDoctorId} $idType,
  ${DoctorModel.columnDoctorName} $textType,
  ${DoctorModel.columnDoctorSpecialization} $textType,
  ${DoctorModel.columnDoctorAddress} $textType,
  ${DoctorModel.columnDoctorMobileNumber} $textType,
  ${DoctorModel.columnDoctorPhoneNumber} $textType
  )
''');
  }

  /*
      Function Add visit
   */

  Future<int> addVisit(VisitModel visitModel) async {
    final db = await instance!.database;
    final id = await db!.insert(VisitModel.visitTable, visitModel.toJson());
    return id;
  }
  /*
      Function Add Doctor
   */

  Future<int> addDoctor(DoctorModel doctorModel) async {
    final db = await instance!.database;
    final id = await db!.insert(DoctorModel.doctorTable, doctorModel.toJson());
    return id;
  }

  /*
        Function Add Prescription
   */
  Future<int> addPrescription(PrescriptionModel prescriptionModel) async {
    final db = await instance!.database;
    final id = await db!.insert(
        PrescriptionModel.prescriptionTable, prescriptionModel.toJson());
    return id;
  }

  /*
        Function Add Drugs
   */
  Future<int> addDrugs(DrugsModel drugsModel) async {
    final db = await instance!.database;
    final id = await db!.insert(DrugsModel.drugsTable, drugsModel.toJson());
    return id;
  }

  /*
        Function Add Notification
   */
  Future<int> addNotification(NotificationModel notificationModel) async {
    final db = await instance!.database;
    final id = await db!.insert(
        NotificationModel.notificationTable, notificationModel.toJson());
    return id;
  }

  /*
        Function Get Visits
   */
  Future<VisitModel> getVisits(int id) async {
    final db = await instance!.database;

    final maps = await db!.query(
      VisitModel.visitTable,
      columns: VisitModel.values,
      where: '${VisitModel.columnVisitId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return VisitModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  /*
        Function Get Doctors
   */
  Future<List<DoctorModel>?> getDoctors() async {
    final db = await instance!.database;

    final results = await db!.query(
      DoctorModel.doctorTable,
      columns: DoctorModel.values,
    );

    if (results.isNotEmpty) {
      return results.map((e) => DoctorModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  /*
        Function Get Last Visits
   */
  Future<VisitModel?> getLastVisit() async {
    final db = await instance!.database;

    final result = await db!.query(
      VisitModel.visitTable,
      columns: VisitModel.values,
    );
    print("data visit : $result");
    if (result.isNotEmpty) {
      return VisitModel.fromJson(result.last);
    } else {
      return null;
    }
  }

/*
        Function Get All  Visits
   */
  Future<List<VisitModel>> getAllVisits() async {
    final db = await instance!.database;

    final result = await db!.query(
      VisitModel.visitTable,
      columns: VisitModel.values,
    );

    return result.map((e) => VisitModel.fromJson(e)).toList();
  }

  /*
        Function Get Prescription by visit
   */
  Future<List<PrescriptionModel>?> getPrescriptionByVisitId(int visitId) async {
    final db = await instance!.database;

    final results = await db!.query(
      PrescriptionModel.prescriptionTable,
      columns: PrescriptionModel.values,
      where: '${PrescriptionModel.columnPrescriptionVisitId} = ?',
      whereArgs: [visitId],
    );

    if (results.isNotEmpty) {
      return results.map((e) => PrescriptionModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  /*
        Function Get Last Prescription
   */
  Future<PrescriptionModel?> getLastPrescription() async {
    final db = await instance!.database;

    final maps = await db!.query(
      PrescriptionModel.prescriptionTable,
      columns: PrescriptionModel.values,
    );
    // print("data visit : $maps");
    if (maps.isNotEmpty) {
      return PrescriptionModel.fromJson(maps.last);
    } else {
      return null;
    }
  }

  /*
        Function Get Drugs By Prescription Id
   */
  Future<List<DrugsModel>?> getDrugsByPrescriptionId(int presId) async {
    final db = await instance!.database;

    final results = await db!.query(
      DrugsModel.drugsTable,
      columns: DrugsModel.values,
      where: '${DrugsModel.columnDrugsPrescriptionId} = ?',
      whereArgs: [presId],
    );

    if (results.isNotEmpty) {
      return results.map((e) => DrugsModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  /*
        Function Get Drugs By Prescription Id and name
   */
  Future<List<DrugsModel>?> getDrugsByPrescriptionIdAndDrugsName(
      int presId, String name) async {
    final db = await instance!.database;

    final results = await db!.query(
      DrugsModel.drugsTable,
      columns: DrugsModel.values,
      where:
          '${DrugsModel.columnDrugsPrescriptionId} = ? AND ${DrugsModel.columnDrugsName} = ?',
      whereArgs: [presId, name],
    );

    if (results.isNotEmpty) {
      return results.map((e) => DrugsModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  /*
        Function Get Last Drugs
   */
  Future<DrugsModel?> getLastDrugs() async {
    final db = await instance!.database;

    final results = await db!.query(
      DrugsModel.drugsTable,
      columns: DrugsModel.values,
    );

    if (results.isNotEmpty) {
      return DrugsModel.fromJson(results.last);
    } else {
      return null;
    }
  }

  /*
        Function Get All Notification
   */
  Future<List<NotificationModel>?> getAllNotification() async {
    final db = await instance!.database;

    final maps = await db!.query(NotificationModel.notificationTable,
        columns: NotificationModel.values,
        orderBy: '${NotificationModel.columnNotificationId} DESC');

    if (maps.isNotEmpty) {
      return maps.map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  /*
        Function Get   Notification By Status
   */
  Future<List<NotificationModel>?> getNotificationByStatus() async {
    final db = await instance!.database;

    final maps = await db!.query(
      NotificationModel.notificationTable,
      columns: NotificationModel.values,
      where: '${NotificationModel.columnNotificationStatus} = ?',
      whereArgs: [0],
    );

    if (maps.isNotEmpty) {
      return maps.map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  /*
        Function Get  Notification By Drugs
   */
  Future<List<NotificationModel>?> getNotificationByDrugsId(int drugsId) async {
    final db = await instance!.database;

    final maps = await db!.query(
      NotificationModel.notificationTable,
      columns: NotificationModel.values,
      where: '${NotificationModel.columnNotificationDrugsID} = ?',
      whereArgs: [drugsId],
    );

    if (maps.isNotEmpty) {
      return maps.map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  /*
        Function Get  Notification By Drugs
   */
  Future<int> updateNotification(NotificationModel notificationModel) async {
    final db = await instance!.database;

    return db!.update(
      NotificationModel.notificationTable,
      notificationModel.toJson(),
      where: '${NotificationModel.columnNotificationId} = ?',
      whereArgs: [notificationModel.id],
    );
  }

  Future<int> deleteVisit(int id) async {
    final db = await instance!.database;

    return await db!.delete(
      VisitModel.visitTable,
      where: '${VisitModel.columnVisitId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePrescription(int id) async {
    final db = await instance!.database;

    return await db!.delete(
      PrescriptionModel.prescriptionTable,
      where: '${PrescriptionModel.columnPrescriptionId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePrescriptionByVisitId(int id) async {
    final db = await instance!.database;

    return await db!.delete(
      PrescriptionModel.prescriptionTable,
      where: '${PrescriptionModel.columnPrescriptionVisitId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteDrugs(int id) async {
    final db = await instance!.database;
    return await db!.delete(
      DrugsModel.drugsTable,
      where: '${DrugsModel.columnDrugsId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteDrugsByPrescriptionId(int id) async {
    final db = await instance!.database;
    return await db!.delete(
      DrugsModel.drugsTable,
      where: '${DrugsModel.columnDrugsPrescriptionId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteNotification(int id) async {
    final db = await instance!.database;

    return await db!.delete(
      NotificationModel.notificationTable,
      where: '${NotificationModel.columnNotificationId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteNotificationByDrugsId(int id) async {
    final db = await instance!.database;

    return await db!.delete(
      NotificationModel.notificationTable,
      where: '${NotificationModel.columnNotificationDrugsID} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance!.database;
    db!.close();
  }
}

class DoctorModel {
  /* Table Doctor */
  static final doctorTable = "doctor_table";

  static final columnDoctorId = "id";
  static final columnDoctorName = "name";
  static final columnDoctorSpecialization = "specialization";
  static final columnDoctorAddress = "address";
  static final columnDoctorMobileNumber = "mobile";
  static final columnDoctorPhoneNumber = "phone";

  static final List<String> values = [
    /// Add all fields
    columnDoctorId,
    columnDoctorName,
    columnDoctorSpecialization,
    columnDoctorAddress,
    columnDoctorMobileNumber,
    columnDoctorPhoneNumber,
  ];
  int? id;
  String? name;
  String? specialization;
  String? address;
  String? mobile;
  String? phone;

  DoctorModel(
      {this.id,
      this.name,
      this.specialization,
      this.address,
      this.mobile,
      this.phone});

  static DoctorModel fromJson(Map<String, Object?> json) => DoctorModel(
      id: json[columnDoctorId] as int,
      name: json[columnDoctorName] as String,
      specialization: json[columnDoctorSpecialization] as String,
      address: json[columnDoctorAddress] as String,
      mobile: json[columnDoctorMobileNumber] as String,
      phone: json[columnDoctorPhoneNumber] as String);

  Map<String, Object?> toJson() => {
        if (id != null) columnDoctorId: id!,
        columnDoctorName: name!,
        columnDoctorSpecialization: specialization!,
        columnDoctorAddress: address!,
        columnDoctorMobileNumber: mobile!,
        columnDoctorPhoneNumber: phone!,
      };
}

class VisitModel {
  /* Table visit */
  static final visitTable = "doctor_visit_table";

  static final columnVisitId = "visit_id";
  static final columnDoctorName = "visit_doctor_name";
  static final columnDoctorSpec = "visit_doctor_spec";
  static final columnAddress = "visit_address";
  static final columnPhoneNumber = "visit_phone_address";
  static final columnDateTime = "visit_date_time";
  static final columnListImage = "visit_list_image";
  static final columnSymptoms = "visit_symptoms";
  static final columnDiagnosis = "visit_diagnosis";

  static final List<String> values = [
    /// Add all fields
    columnVisitId,
    columnDoctorName,
    columnDoctorSpec,
    columnAddress,
    columnPhoneNumber,
    columnDateTime,
    columnListImage,
    columnSymptoms,
    columnDiagnosis
  ];

  int? id;
  String? doctorName;
  String? doctorSpec;
  String? address;
  String? date;
  String? listImage;
  String? phoneNumber;
  String? symptoms;
  String? diagnosis;

  VisitModel(
      {this.id,
      this.doctorName,
      this.doctorSpec,
      this.address,
      this.phoneNumber,
      this.date,
      this.listImage,
      this.symptoms,
      this.diagnosis});

  static VisitModel fromJson(Map<String, Object?> json) => VisitModel(
        id: json[columnVisitId] as int,
        doctorName: json[columnDoctorName] as String,
        doctorSpec: json[columnDoctorSpec] as String,
        address: json[columnAddress] as String,
        date: json[columnDateTime] as String,
        listImage: json[columnListImage] as String,
        phoneNumber: json[columnPhoneNumber] as String,
        symptoms: json[columnSymptoms] as String,
        diagnosis: json[columnDiagnosis] as String,
      );

  Map<String, Object?> toJson() => {
        if (id != null) columnVisitId: id!,
        columnDoctorName: doctorName!,
        columnDoctorSpec: doctorSpec!,
        columnAddress: address!,
        columnDateTime: date!,
        columnListImage: listImage!,
        columnPhoneNumber: phoneNumber!,
        columnSymptoms: symptoms!,
        columnDiagnosis: diagnosis!,
      };
}

class PrescriptionModel {
  /* Table prescription */
  static final prescriptionTable = "prescription_table";
  static final columnPrescriptionId = "pres_id";
  static final columnPrescriptionDrugs = "pres_list_drugs";
  static final columnPrescriptionImage = "pres_Image";
  static final columnPrescriptionVisitId = "pres_visit_id";

  static final List<String> values = [
    /// Add all fields
    columnPrescriptionId,
    columnPrescriptionDrugs,
    columnPrescriptionImage,
    columnPrescriptionVisitId
  ];

  int? id;

  String? listDrugs;
  String? image;
  int? visitId;

  PrescriptionModel({this.id, this.listDrugs, this.image, this.visitId});

  static PrescriptionModel fromJson(Map<String, Object?> json) =>
      PrescriptionModel(
        id: json[columnPrescriptionId] as int,
        listDrugs: json[columnPrescriptionDrugs] as String,
        image: json[columnPrescriptionImage] as String,
        visitId: json[columnPrescriptionVisitId] as int,
      );

  Map<String, Object?> toJson() => {
        if (id != null) columnPrescriptionId: id!,
        columnPrescriptionDrugs: listDrugs!,
        columnPrescriptionImage: image!,
        columnPrescriptionVisitId: visitId!
      };
}

class DrugsModel {
  /* Table Drugs */
  static final drugsTable = "drugs_table";
  static final columnDrugsId = "drugs_id";
  static final columnDrugsName = "drugs_name";
  static final columnDrugsTakes = "drugs_take";
  static final columnDrugsDate = "drugs_date";
  static final columnDrugsTime = "drugs_time";
  static final columnDrugsDuration = "drugs_duration";
  static final columnDrugsPrescriptionId = "drugs_prescription_id";

  static final List<String> values = [
    /// Add all fields
    columnDrugsId,
    columnDrugsName,
    columnDrugsTakes,
    columnDrugsDate,
    columnDrugsTime,
    columnDrugsDuration,
    columnDrugsPrescriptionId
  ];

  int? id;
  String? name;
  String? take;
  String? date;
  String? time;
  String? duration;
  int? presId;

  DrugsModel(
      {this.id,
      this.name,
      this.take,
      this.date,
      this.time,
      this.duration,
      this.presId});

  static DrugsModel fromJson(Map<String, Object?> json) => DrugsModel(
        id: json[columnDrugsId] as int,
        name: json[columnDrugsName] as String,
        take: json[columnDrugsTakes] as String,
        date: json[columnDrugsDate] as String,
        time: json[columnDrugsTime] as String,
        duration: json[columnDrugsDuration] as String,
        presId: json[columnDrugsPrescriptionId] as int,
      );

  Map<String, Object?> toJson() => {
        if (id != null) columnDrugsId: id!,
        columnDrugsName: name!,
        columnDrugsTakes: take!,
        columnDrugsDate: date!,
        columnDrugsTime: time!,
        columnDrugsDuration: duration!,
        columnDrugsPrescriptionId: presId!,
      };
}

class NotificationModel {
  /* Table Drugs */
  static final notificationTable = "notification_table";
  static final columnNotificationId = "notification_id";
  static final columnNotificationTitle = "notification_title";
  static final columnNotificationBody = "notification_body";
  static final columnNotificationDate = "notification_date";
  static final columnNotificationTime = "notification_time";
  static final columnNotificationDrugsID = "notification_drugs_Id";
  static final columnNotificationDrugsData = "notification_drugs_data";
  static final columnNotificationStatus = "notification_status";

  static final List<String> values = [
    /// Add all fields
    columnNotificationId,
    columnNotificationTitle,
    columnNotificationBody,
    columnNotificationDate,
    columnNotificationTime,
    columnNotificationDrugsID,
    columnNotificationDrugsData,
    columnNotificationStatus,
  ];

  int? id;
  String? title;
  String? body;
  String? date;
  String? time;
  String? drugData;
  int? drugsId;
  int? status;

  NotificationModel(
      {this.id,
      this.title,
      this.body,
      this.date,
      this.time,
      this.drugData,
      this.status,
      this.drugsId});

  static NotificationModel fromJson(Map<String, Object?> json) =>
      NotificationModel(
        id: json[columnNotificationId] as int,
        title: json[columnNotificationTitle] as String,
        body: json[columnNotificationBody] as String,
        date: json[columnNotificationDate] as String,
        time: json[columnNotificationTime] as String,
        drugData: json[columnNotificationDrugsData] as String,
        drugsId: json[columnNotificationDrugsID] as int,
        status: json[columnNotificationStatus] as int,
      );

  Map<String, Object?> toJson() => {
        if (id != null) columnNotificationId: id!,
        columnNotificationTitle: title!,
        columnNotificationBody: body!,
        columnNotificationTime: time!,
        columnNotificationDate: date!,
        columnNotificationDrugsID: drugsId!,
        columnNotificationDrugsData: drugData!,
        columnNotificationStatus: status!
      };
}
