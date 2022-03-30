// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:convert';
import 'dart:typed_data';

import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/PatienProfile/patient_add_prescription.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/Widgets/image_view.dart';

import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class DoctorPrescriptionSummary extends StatefulWidget {
  final lang;
  VisitModel? visitModel;
  DoctorPrescriptionSummary({Key? key, this.lang, this.visitModel})
      : super(key: key);

  @override
  _DoctorPrescriptionSummaryState createState() =>
      _DoctorPrescriptionSummaryState();
}

class _DoctorPrescriptionSummaryState extends State<DoctorPrescriptionSummary> {
  var lang;
  VisitModel? _visitModel;
  var labTestsController = [];
  var prescriptionImageController = [];

  List<PrescriptionModel> _prescriptionList = [];
  List<List<dynamic>> _prescriptionImageList = [];
  List<List<dynamic>> _prescriptionDrugsList = [];

  _getPrescriptionOfVisit(int id) async {
    print("visi id :$id");
    _prescriptionList =
        (await DatabaseHelper.instance?.getPrescriptionByVisitId(id))!;
    print("prescription list : $_prescriptionList");
    for (int i = 0; i < _prescriptionList.length; i++) {
      print("prescription id : ${_prescriptionList[i].id}");
      setState(() {
        _prescriptionImageList.add(jsonDecode(_prescriptionList[i].image!));
        _prescriptionDrugsList.add(jsonDecode(_prescriptionList[i].listDrugs!));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lang = widget.lang;
    _visitModel = widget.visitModel;
    labTestsController = jsonDecode(_visitModel!.listImage!);
    _getPrescriptionOfVisit(_visitModel!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: <Widget>[BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    child: Text(widget.lang == "en"
                        ? "Doctor Visits Summary"
                        : "ملخص زيارات الأطباء")),
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 220 - MediaQuery.of(context).padding.top - 50,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(children: <Widget>[
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                )),
                                Text(
                                    lang == "en"
                                        ? " Doctor Info "
                                        : "معلومات الطبيب",
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
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade50),
                                    child: Text(
                                      lang == "en"
                                          ? "Doctor Name"
                                          : "اسم الطبيب",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      _visitModel!.doctorName!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade50),
                                    child: Text(
                                      lang == "en" ? 'Speciality' : "التخصص",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      _visitModel!.doctorSpec!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade50),
                                    child: Text(
                                      lang == "en" ? 'Address' : 'العنوان',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      _visitModel!.address!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade50),
                                    child: Text(
                                      lang == "en"
                                          ? 'Phone Number'
                                          : 'رقم الهاتف',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      _visitModel!.phoneNumber!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(children: <Widget>[
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                )),
                                Text(
                                    lang == "en"
                                        ? " Medical Case Story "
                                        : "بيانات الزيارة",
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
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade50),
                                    child: Text(
                                      lang == "en" ? 'Date' : 'التاريح',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      _visitModel!.date!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade50),
                                    child: Text(
                                      lang == "en"
                                          ? 'Lab Tests Images'
                                          : 'صور التحاليل المخبرية',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
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
                                        tag: "lab test images ",
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                            tag: "lab test images ",
                                            imageUrl: bytes,
                                          );
                                        }));
                                      },
                                    ),
                                  );
                                }).toList()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade50),
                                    child: Text(
                                      lang == "en" ? 'Diagnosis' : 'التشخيص',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      _visitModel!.diagnosis!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade50),
                                    child: Text(
                                      lang == "en" ? 'Symptoms' : "الأعراض",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      _visitModel!.symptoms!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                )),
                                Text(
                                    lang == "en"
                                        ? " Prescription "
                                        : " الوصفات ",
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
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  primary: true,
                                  shrinkWrap: true,
                                  itemCount: _prescriptionList.length,
                                  itemBuilder: (context, i) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 200,
                                              padding: EdgeInsets.only(
                                                  top: 2,
                                                  bottom: 2,
                                                  right: 10,
                                                  left: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade50),
                                              child: Text(
                                                lang == "en"
                                                    ? 'Prescription Images'
                                                    : 'صور الوصفات',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Wrap(
                                              children:
                                                  _prescriptionImageList[i]
                                                      .map((e) {
                                            Uint8List bytes = base64Decode(
                                                e["image"].toString());
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  right: 5, left: 5),
                                              child: InkWell(
                                                child: Hero(
                                                  tag: "prescription  image ",
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                    return ImageView(
                                                      tag:
                                                          "prescription  image ",
                                                      imageUrl: bytes,
                                                    );
                                                  }));
                                                },
                                              ),
                                            );
                                          }).toList()),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 200,
                                              padding: EdgeInsets.only(
                                                  top: 2,
                                                  bottom: 2,
                                                  right: 10,
                                                  left: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade50),
                                              child: Text(
                                                lang == "en"
                                                    ? 'Drugs'
                                                    : 'الأدوية',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                        ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            primary: true,
                                            shrinkWrap: true,
                                            itemCount: _prescriptionDrugsList[i]
                                                .length,
                                            itemBuilder: (context, index) {
                                              return _rowItem(
                                                  _prescriptionDrugsList[i]
                                                      [index]['Brand_Name'],
                                                  () {
                                                print(
                                                    "id ${_prescriptionList[i].id}");
                                                // Navigator.push(context,
                                                //     MaterialPageRoute(
                                                //         builder: (_) {
                                                //   return DoctorDrugsSummary(
                                                //     lang: lang,
                                                //     presentId:
                                                //         _prescriptionList[i].id,
                                                //     drugsName:
                                                //         _prescriptionDrugsList[
                                                //                 i][index]
                                                //             ['Brand_Name'],
                                                //   );
                                                // }));
                                              });
                                            }),
                                        Divider(),
                                      ],
                                    );
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 5,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Color(0xff5C376D))),
                                    child: Text(
                                      lang == 'en'
                                          ? 'Add Prescription'
                                          : 'إضافة وصفة',
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
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PrescriptionScreen(
                                                      lang: lang,
                                                      visitId:
                                                          _visitModel!.id!)));
                                    },
                                    color: Color(0xff5C376D),
                                  )),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget _rowItem(String name, VoidCallback btnClick) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Card(
            elevation: 5.0,
            margin: EdgeInsets.only(top: 10, bottom: 10, right: 20),
            shadowColor: Color(0xff5C376D),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff5C376D))),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xff5C376D),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: btnClick,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
