// ignore_for_file: prefer_const_constructors

import 'package:adwiah/Models/doctor_visit.dart';
import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/PatienProfile/PrimaryPages/doctors_prescription_summary.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:flutter/material.dart';

class DoctorsVisitsSummary extends StatefulWidget {
  final String lang;

  DoctorsVisitsSummary({this.lang = "en"});

  @override
  _DoctorsVisitsSummaryState createState() => _DoctorsVisitsSummaryState();
}

class _DoctorsVisitsSummaryState extends State<DoctorsVisitsSummary> {
  List<DoctorVisit> visits = <DoctorVisit>[];
  List<VisitModel> _visitList = [];
  var db = DatabaseHelper.instance;
  bool _isLoading = true;
  var lang;

  void initData() async {
    // List a = await storage.read(key: 'doctorVisitsList') != null
    //     ? await jsonDecode(await storage.read(key: 'doctorVisitsList'))
    //     : [];
    setState(() {
      // visits = a.map((e) => DoctorVisit.fromJson(e)).toList();
    });
  }

  void _getData() async {
    _visitList = await db!.getAllVisits();
    setState(() {
      _isLoading = false;
    });
  }

  void deleteVisit(int visitId) async {
    List<int> prescriptionId = [];
    List<int> drugsId = [];

    var deleteVisit = await DatabaseHelper.instance?.deleteVisit(visitId);
    print("deleteVisit : $deleteVisit");

    var prescriptionData =
        await DatabaseHelper.instance?.getPrescriptionByVisitId(visitId) ?? [];
    for (int i = 0; i < prescriptionData.length; i++) {
      prescriptionId.add(prescriptionData[i].id!);
    }

    for (int i = 0; i < prescriptionId.length; i++) {
      var drugsData = await DatabaseHelper.instance
              ?.getDrugsByPrescriptionId(prescriptionId[i]) ??
          [];
      for (int j = 0; j < drugsData.length; j++) {
        drugsId.add(drugsData[i].id!);
        var deleteNotification = await DatabaseHelper.instance
            ?.deleteNotificationByDrugsId(drugsData[i].id!);
        print("deleteNotification :$deleteNotification");
      }
    }

    for (int i = 0; i < prescriptionId.length; i++) {
      var deleteDrugs = await DatabaseHelper.instance
          ?.deleteDrugsByPrescriptionId(prescriptionId[i]);
      print("deleteDrugs :$deleteDrugs");
    }

    var deletePrescription =
        await DatabaseHelper.instance?.deletePrescriptionByVisitId(visitId);
    print("deletePrescription :$deletePrescription");

    _getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    lang = widget.lang;
    // initData();
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
              child: _isLoading
                  ? Container(child: Center(child: CircularProgressIndicator()))
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height:
                                220 - MediaQuery.of(context).padding.top - 50,
                          ),
                          Row(children: <Widget>[
                            Expanded(
                                child: Divider(
                              thickness: 1,
                              color: Colors.black,
                            )),
                            Text(
                                lang == "en"
                                    ? " Visit List "
                                    : "قائمة الزيارات",
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
                          Expanded(
                            child: ListView.builder(
                              itemCount: _visitList.length,
                              itemBuilder: (context, index) {
                                return visitCard(_visitList[index], () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return DoctorPrescriptionSummary(
                                      lang: lang,
                                      visitModel: _visitList[index],
                                    );
                                  }));
                                });
                              },
                            ),
                          ),
                        ],
                      ),
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

  Widget visitCard(VisitModel visitModel, btnClick) {
    return InkWell(
      onTap: btnClick,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          lang == "en" ? "Doctor Name" : "اسم الطبيب",
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
                          visitModel.doctorName!,
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
                    height: 5,
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
                          visitModel.doctorSpec!,
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
                    height: 5,
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
                          visitModel.symptoms!,
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
                    height: 5,
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
                          visitModel.diagnosis!,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(lang == "en"
                                          ? "Delete Visit ?"
                                          : "حذف الزيارة؟"),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      lang == "en" ? "No" : "لا",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black87),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      lang == "en" ? "Yes" : "نعم",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black54),
                                    ),
                                    onPressed: () {
                                      deleteVisit(visitModel.id!);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Color(0xff5C376D),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent.shade100,
                          borderRadius: BorderRadius.circular(50),
                          // border: Border.all(color: Color(0xff5C376D))
                        ),
                        child: Text(
                          visitModel.date!,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: Material(
              elevation: 6,
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
