// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:adwiah/Models/patient.dart';
import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:adwiah/View/StudyInteractions/ViewModel/interactions_view_model.dart';
import 'package:adwiah/Widgets/FloatingButton/dosage_detaild_box_view.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/Widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sized_context/sized_context.dart';

import 'patient_add_drugs_page.dart';

class PrescriptionScreen extends StatefulWidget {
  final lang;
  int? visitId;
  PrescriptionScreen({this.lang = "en", this.visitId});

  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  List<MultiSelectItem<dynamic>>? _midiList;
  var lang;
  var labTestsController = [];
  List<dynamic> _drugSelection = [];
  List<String> _drugsNameAddList = [];
  List<dynamic> selectedDrugs = [];

  TextEditingController imageController = new TextEditingController();
  // CalendarController cal = CalendarController();
  int visitId = 0;
  int prescriptionId = 0;
  String drugsName = "Drugs Name";
  bool _loadingDrugsList = true;
  Patient? patient;
  List midi_cotroller = [];
  final storage = GetStorage();
  InitialAppController controller = Get.find<InitialAppController>();
  StudyInteractionsController studyctrl =
      Get.find<StudyInteractionsController>();
  void initData() async {
    List midi = controller.brandList;
    setState(() {
      _midiList = midi
          .map((item) => MultiSelectItem(
              item, item['Name'] != null ? item['Name'] : item['Brand_Name']))
          .toList();
      print(midi);
    });
    var p = Patient.fromJson(jsonDecode(await storage.read('patient') ?? '{}'));
    setState(() {
      patient = p;
      midi_cotroller = p.chronic_midicens != null ? p.chronic_midicens : [];
      print("midi:");
      print(midi_cotroller);
    });
  }

  void _saveData() async {
    var imagesList = jsonEncode(labTestsController);
    var drugsList = jsonEncode(_drugSelection);
    if (labTestsController.isNotEmpty) {
      var result =
          await DatabaseHelper.instance!.addPrescription(PrescriptionModel(
        image: imagesList,
        listDrugs: drugsList,
        visitId: visitId,
      ));
      print("add result : $result");
      if (result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff5C376D),
            content: Text(
              lang == "en"
                  ? "Recipe added successfully"
                  : "تم إضافة الوصفة بنجاح",
              style: TextStyle(color: Colors.white),
            )));
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff5C376D),
            content: Text(
              lang == "en"
                  ? "An error occurred during the adding process"
                  : "حدث خطأ أثناء عملية الإضافة",
              style: TextStyle(color: Colors.white),
            )));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xff5C376D),
          content: Text(
            lang == "en"
                ? "Fields must be filled with appropriate values"
                : "يجب ملئ الحقول بالقيم المناسبة",
            style: TextStyle(color: Colors.white),
          )));
    }
  }

  void _getLastPrescription() async {
    PrescriptionModel? data =
        await DatabaseHelper.instance!.getLastPrescription();
    print("data : $data");
    if (data != null) {
      print("prescription model : ${data.id}");
      prescriptionId = data.id! + 1;
      print("new prescription id : $prescriptionId");
    } else {
      prescriptionId = 1;
      print("new prescription id : $prescriptionId");
    }
  }

  void show(List res, List res2) async {
    List<Widget> text = [];
    if (res != null) {
      for (var i = 0; i < res.length; i += 1) {
        if (res[i]['note'] == null || res[i]['note'] == "") {
          (res[i]['IngAWith_name'] != null && res[i]['IngAWith_name'] != '') ||
                  (res[i]['IngA_name'] != '' && res[i]['IngA_name'] != null)
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (TextSpan(
                        children: [
                          TextSpan(
                              text: res[i]['IngAWith_name'] != null
                                  ? res[i]['IngAWith_name']
                                  : res[i]['IngA_name'],
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          TextSpan(
                              text: ' interact with ',
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: res[i]['IngBWith_name'] != null
                                  ? res[i]['IngBWith_name']
                                  : res[i]['IngB_name'],
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          TextSpan(
                              text: ' as the following : ',
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400))
                        ],
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w400))),
                  ])))
              : null;

          res[i]['Severity_Level'] != null && res[i]['Severity_Level'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i]['Severity_Level'] != null &&
                            res[i]['Severity_Level'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'Severity Level : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i]['Severity_Level'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;
          res[i]['InterActionType'] != null && res[i]['InterActionType'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i]['InterActionType'] != null &&
                            res[i]['InterActionType'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'InterAction Type  : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i]['InterActionType'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;
          res[i]['Recommendation_text'] != null &&
                  res[i]['Recommendation_text'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i]['Recommendation_text'] != null &&
                            res[i]['Recommendation_text'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'Recommendation : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i]['Recommendation_text'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;

          res[i]['More_Info_text'] != null && res[i]['More_Info_text'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i]['More_Info_text'] != null &&
                            res[i]['More_Info_text'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'More Infos : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i]['More_Info_text'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;

          res[i]['nointeraction'] != null && res[i]['nointeraction'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i]['nointeraction'] != null &&
                            res[i]['nointeraction'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'No Interaction : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i]['nointeraction'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;
        } else {
          text.add(RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                (TextSpan(
                    children: [
                      TextSpan(
                          text: res[i]['IngAWith_name'] != null
                              ? res[i]['IngAWith_name']
                              : res[i]['IngA_name'],
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      TextSpan(
                          text: ' interact with ',
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: res[i]['IngBWith_name'] != null
                              ? res[i]['IngBWith_name']
                              : res[i]['IngB_name'],
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      TextSpan(
                          text: ' as the following : ',
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                    ],
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400))),
              ])));

          text.add(RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                (res[i]['Severity_Level'] != null
                    ? TextSpan(children: [
                        TextSpan(
                            text: 'Severity Level : ',
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                        TextSpan(
                            text: res[i]['Severity_Level'],
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w400))
                      ])
                    : TextSpan(text: '')),
              ])));

          text.add(RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                (TextSpan(children: [
                  TextSpan(
                      text: 'Note : ',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: res[i]['note'],
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w400))
                ])),
              ])));

          res[i]['nointeraction'] != null && res[i]['nointeraction'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i]['nointeraction'] != null &&
                            res[i]['nointeraction'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'No Interaction : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i]['nointeraction'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;
        }
      }
    } else {
      text.add(RichText(
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'No Interactions found between chosen drugs',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 17,
                  fontWeight: FontWeight.w400))));
    }

    //-----------------------------------------------------------------------------------
    text.add(RichText(
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textAlign: TextAlign.start,
        text: TextSpan(children: [
          TextSpan(children: [
            TextSpan(
                text:
                    '\nStudy Interactions between selected drugs and chronic medicens\n',
                style: TextStyle(
                    height: 1.5,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.w900)),
          ])
        ])));
    if (res2 != null) {
      text.add(RichText(
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textAlign: TextAlign.start,
          text: TextSpan(children: [
            TextSpan(children: [
              TextSpan(
                  text:
                      '\n\nInteractions bitween chosen drugs and chronic medicens\n\n',
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.w800)),
            ])
          ])));
      for (var i = 0; i < res2.length; i += 1) {
        if (res2[i]['note'] == null || res2[i]['note'] == "") {
          (res2[i]['IngAWith_name'] != null &&
                      res2[i]['IngAWith_name'] != '') ||
                  (res2[i]['IngA_name'] != '' && res2[i]['IngA_name'] != null)
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (TextSpan(
                        children: [
                          TextSpan(
                              text: res2[i]['IngAWith_name'] != null
                                  ? res2[i]['IngAWith_name']
                                  : res2[i]['IngA_name'],
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          TextSpan(
                              text: ' interact with ',
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: res2[i]['IngBWith_name'] != null
                                  ? res2[i]['IngBWith_name']
                                  : res2[i]['IngB_name'],
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          TextSpan(
                              text: ' as the following : ',
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400))
                        ],
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w400))),
                  ])))
              : null;

          res2[i]['Severity_Level'] != null && res2[i]['Severity_Level'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res2[i]['Severity_Level'] != null &&
                            res2[i]['Severity_Level'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'Severity Level : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res2[i]['Severity_Level'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;
          res2[i]['InterActionType'] != null && res2[i]['InterActionType'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res2[i]['InterActionType'] != null &&
                            res2[i]['InterActionType'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'InterAction Type  : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res2[i]['InterActionType'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;
          res2[i]['Recommendation_text'] != null &&
                  res2[i]['Recommendation_text'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res2[i]['Recommendation_text'] != null &&
                            res2[i]['Recommendation_text'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'Recommendation : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res2[i]['Recommendation_text'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;

          res2[i]['More_Info_text'] != null && res2[i]['More_Info_text'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i]['More_Info_text'] != null &&
                            res[i]['More_Info_text'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'More Infos : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res2[i]['More_Info_text'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;

          res2[i]['nointeraction'] != null && res2[i]['nointeraction'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res2[i]['nointeraction'] != null &&
                            res2[i]['nointeraction'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'No Interaction : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res2[i]['nointeraction'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;
        } else {
          text.add(RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                (TextSpan(
                    children: [
                      TextSpan(
                          text: res2[i]['IngAWith_name'] != null
                              ? res2[i]['IngAWith_name']
                              : res2[i]['IngA_name'],
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      TextSpan(
                          text: ' interact with ',
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: res2[i]['IngBWith_name'] != null
                              ? res2[i]['IngBWith_name']
                              : res2[i]['IngB_name'],
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      TextSpan(
                          text: ' as the following : ',
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                    ],
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400))),
              ])));

          text.add(RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                (res2[i]['Severity_Level'] != null
                    ? TextSpan(children: [
                        TextSpan(
                            text: 'Severity Level : ',
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                        TextSpan(
                            text: res2[i]['Severity_Level'],
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w400))
                      ])
                    : TextSpan(text: '')),
              ])));

          text.add(RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                (TextSpan(children: [
                  TextSpan(
                      text: 'Note : ',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: res2[i]['note'],
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w400))
                ])),
              ])));

          res2[i]['nointeraction'] != null && res2[i]['nointeraction'] != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res2[i]['nointeraction'] != null &&
                            res2[i]['nointeraction'] != ''
                        ? TextSpan(children: [
                            TextSpan(
                                text: 'No Interaction : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res2[i]['nointeraction'],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;
        }
      }
    } else {
      text.add(RichText(
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textAlign: TextAlign.center,
          text: TextSpan(
              text:
                  'No Interactions found between chosen drugs and Chronic medicens',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 17,
                  fontWeight: FontWeight.w400))));
    }
    Navigator.pop(context);
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              height: text.length > 1 ? 600 : 200,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Material(
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Study Result',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )),
                          IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                      Expanded(child: DosageDetails(text)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  //============================================//

  void getStudyInteractions() async {
    String ids = '';
    selectedDrugs.forEach((value) {
      ids += value["Ing_ID"].toString() + ',';
    });
    if (ids != null && ids.length > 0) {
      ids = ids.substring(0, ids.length - 1);
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Study interactions ......'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xffed5565))),
                ),
              ],
            ),
          ),
        );
      },
    );

    List res = await studyctrl.getStudyIng(ids);
    midi_cotroller.forEach((value) {
      ids += value["ID"] != null
          ? value["ID"].toString()
          : value["Ing_ID"].toString() + ',';
    });
    List res2 = await studyctrl.getStudyIng(ids);
    show(res, res2);
  }

//====================================================//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lang = widget.lang;
    visitId = widget.visitId!;
    print("visit id : $visitId");
    initData();
    _getLastPrescription();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _loadingDrugsList = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header()),
          Scaffold(
            drawer: NavDrawer(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: <Widget>[BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    child:
                        Text(lang == "en" ? 'Prescription' : 'الوصفة الطبية')),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 220 - MediaQuery.of(context).padding.top - 50,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          )),
                          Text(lang == "en" ? " Medicines " : "الادوية",
                              style: TextStyle(
                                  color: Color(0xff5C376D),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          )),
                        ]),
                        SizedBox(height: 10),
                        _loadingDrugsList
                            ? CircularProgressIndicator()
                            : InputDecorator(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0 +
                                          ((context.diagonalInches / 6.0)
                                                  .floorToDouble() *
                                              10),
                                      horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  hintText: drugsName,
                                  // lang == "en" ? 'Drugs Name' : "اسم الدواء",
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text(drugsName),
                                    isDense: true,
                                    onChanged: (String? s) {
                                      print("drugs name");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddDrugsPage(
                                                    lang: lang,
                                                    drugsName: drugsName,
                                                    prescriptionId:
                                                        prescriptionId,
                                                  ))).then((value) {
                                        setState(() {
                                          value != null
                                              ? _drugsNameAddList.add(value)
                                              : print("#### no add data ###");
                                        });
                                      });
                                    },
                                    items: _midiList?.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.label,
                                        child: Text(value.label),
                                        onTap: () {
                                          setState(() {
                                            drugsName = value.label;
                                            selectedDrugs.add(value.value);
                                            print(selectedDrugs);

                                            // print(midiList.indexOf(value));
                                            // drugsNameIndex =
                                            //     _drugsList.indexOf(value);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                        Container(
                          child: ListView.builder(
                              itemCount: _drugsNameAddList.length,
                              primary: true,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    child: ListTile(
                                      title: Text(
                                        _drugsNameAddList[index],
                                        style:
                                            TextStyle(color: Color(0xff5C376D)),
                                      ),
                                      leading: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                    ));
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: InkWell(
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: imageController,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.camera_alt_outlined),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  hintText: lang == "en"
                                      ? 'Prescription picture'
                                      : 'صورة الوصفة',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter your date of birth';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            onTap: () async {
                              final picker = ImagePicker();
                              var image = await picker.pickImage(
                                  source: ImageSource.camera,
                                  imageQuality: 100,
                                  maxWidth: 500.0,
                                  maxHeight: 500.0);
                              if (image != null) {
                                String base64file =
                                    base64Encode(await image.readAsBytes());
                                setState(() {
                                  labTestsController.add({"image": base64file});
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Wrap(
                              children: labTestsController.map((e) {
                            Uint8List bytes =
                                base64Decode(e["image"].toString());
                            return Container(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: InkWell(
                                child: Hero(
                                  tag: "image review",
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      bytes,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return ImageView(
                                      tag: "image review",
                                      imageUrl: bytes,
                                    );
                                  }));
                                },
                              ),
                            );
                          }).toList()),
                        ),
                        SizedBox(height: 10),
                        Material(
                            borderRadius: BorderRadius.circular(100),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  side: BorderSide(color: Color(0xff5C376D))),
                              child: Text(
                                lang == 'en'
                                    ? 'Study Interactions'
                                    : 'دراسة التداخلات الدوائية',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 22,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              height: 45 +
                                  ((context.diagonalInches / 6.0)
                                          .floorToDouble() *
                                      15),
                              minWidth: MediaQuery.of(context).size.width / 2,
                              onPressed: getStudyInteractions,
                              color: Color(0xff5C376D),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Material(
                            borderRadius: BorderRadius.circular(100),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  side: BorderSide(color: Color(0xff5C376D))),
                              child: Text(
                                lang == 'en' ? 'Save' : 'حفظ',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 22,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              height: 45 +
                                  ((context.diagonalInches / 6.0)
                                          .floorToDouble() *
                                      15),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: _saveData,
                              color: Color(0xff5C376D),
                            )),
                        SizedBox(height: 10),
                      ],
                    ),
                  ))
                ]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
          child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: BottomControllBar(0))),
    );
  }
}
