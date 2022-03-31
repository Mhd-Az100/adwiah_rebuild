import 'dart:convert';

import 'package:adwiah/Models/patient.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/PatienProfile/Components/card_patient.dart';
import 'package:adwiah/View/PatienProfile/PrimaryPages/patient_add_drugs_single_page.dart';
import 'package:adwiah/View/PatienProfile/PrimaryPages/doctorList.dart';
import 'package:adwiah/View/PatienProfile/PrimaryPages/doctors_visits_summary.dart';
import 'package:adwiah/View/PatienProfile/PrimaryPages/patient_profile.dart';
import 'package:adwiah/View/PatienProfile/PrimaryPages/patient_profile_doctor.dart';
import 'package:adwiah/View/PatienProfile/PrimaryPages/patient_profile_notification.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PatientHome extends StatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  var lang = "en";
  // Patient patient;
  bool isComplete = false;
  final storage = GetStorage();

  void initData() async {
    var p = Patient.fromJson(jsonDecode(
        // ignore: prefer_if_null_operators
        await storage.read('patient') != null
            ? await storage.read('patient')
            : '{}'));
    print("patient : ${p.name}");
    print("gender : ${p.gender}");
    print("date : ${p.dob}");
    if (p.name == null && p.gender == null && p.dob == null) {
      setState(() {
        isComplete = false;
      });
    } else {
      setState(() {
        isComplete = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header2()),
          Scaffold(
            drawer: NavDrawer(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child:
                    FittedBox(child: Text(lang == "en" ? 'Home' : 'الرئيسية')),
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
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 220 - MediaQuery.of(context).padding.top - 55,
                    child: Center(
                      child: FittedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialButton(
                                  minWidth: 130,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        color: lang == 'en'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  height: 45,
                                  onPressed: () {
                                    setState(() {
                                      lang = 'en';
                                    });
                                  },
                                  color: lang == 'en'
                                      ? const Color(0xff5C376D)
                                      : Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  minWidth: 130,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'العربية',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14,
                                        color: lang == 'ar'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  height: 45,
                                  onPressed: () {
                                    setState(() {
                                      lang = 'ar';
                                    });
                                  },
                                  color: lang == 'ar'
                                      ? const Color(0xff5C376D)
                                      : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 15.2,
                      crossAxisSpacing: 7.2,
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      children: [
                        PatienCard(
                            txt: lang == "en"
                                ? 'Patient Profile'
                                : 'معلومات المريض',
                            iscomplate: true,
                            imgPath: 'assets/images/patient.png',
                            ontap: () {
                              Get.to(() => PatientPrifile(lang: lang));
                            }),
                        PatienCard(
                          txt: lang == "en" ? 'Doctor Visit' : 'زيارة طبيب',
                          iscomplate: isComplete,
                          imgPath: 'assets/images/doctor_visit.png',
                          ontap: () {
                            Get.to(() => PatientProfileDoctor(lang: lang));
                          },
                        ),
                        PatienCard(
                          txt: lang == "en" ? 'Doctors List' : 'قائمة الأطباء',
                          iscomplate: isComplete,
                          imgPath: 'assets/images/doctors_list.png',
                          ontap: () {
                            Get.to(() => DoctorsList(lang: lang));
                          },
                        ),
                        PatienCard(
                          txt: lang == "en"
                              ? 'Doctors Visits summary'
                              : 'ملخص زيارات الأطباء',
                          iscomplate: isComplete,
                          imgPath: 'assets/images/resent_results.png',
                          ontap: () {
                            Get.to(() => DoctorsVisitsSummary(lang: lang));
                          },
                        ),
                        PatienCard(
                          txt: lang == "en" ? 'Alarms' : 'التنبيهات',
                          iscomplate: isComplete,
                          imgPath: 'assets/images/notifications.png',
                          ontap: () {
                            Get.to(
                                () => PatientProfileNotification(lang: lang));
                          },
                        ),
                        PatienCard(
                          txt: lang == "en"
                              ? 'Chronic Medication'
                              : 'الأدوية المزمنة',
                          iscomplate: isComplete,
                          imgPath: 'assets/images/28.png',
                          ontap: () {
                            Get.to(() => AddDrugsSinglePage(
                                  lang: lang,
                                ));
                          },
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 9),
                child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: BottomControllBar(0))),
          ),
        ],
      ),
    );
  }
}
