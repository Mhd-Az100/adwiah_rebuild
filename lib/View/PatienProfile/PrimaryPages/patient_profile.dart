// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';

import 'package:adwiah/Models/patient.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' as intl;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sized_context/sized_context.dart';

class PatientPrifile extends StatefulWidget {
  final lang;

  PatientPrifile({this.lang = "en"});

  @override
  _PatientPrifileState createState() => _PatientPrifileState();
}

class _PatientPrifileState extends State<PatientPrifile> {
  StorageHelperController storagectrl = Get.find<StorageHelperController>();

  DateTime selectedDate = DateTime.utc(2000, 1, 1);
  String date = '';
  var dobController = TextEditingController();
  Patient? patient;
  var name_controller = TextEditingController();
  String gender = '';
  var dis_controller = [];
  var midi_cotroller = [];
  var hyper_controller = [];
  var myFormate = intl.DateFormat('d-MM-yyyy');

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialDatePicker(context);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildCupertinoDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null)
                  // ignore: curly_braces_in_flow_control_structures
                  setState(() {
                    selectedDate = picked;
                    dobController.text = myFormate.format(picked);

                    patient!.dob = picked.toString();
                    var p = patient!.toJson();
                    print(p);
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
              },
              initialDateTime: DateTime.now(),
              minimumYear: 1900,
              maximumYear: DateTime.now().year,
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dobController.text = myFormate.format(picked).trim();
        patient?.dob = picked.toString();
        var p = patient?.toJson();
        print("date select : $p");
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  List<MultiSelectItem<dynamic>>? diseaseList;
  List<MultiSelectItem<dynamic>>? midiList;
  final _multiSelectKey = GlobalKey<FormFieldState>();
  final _multiSelect1Key = GlobalKey<FormFieldState>();
  final _multiSelect2Key = GlobalKey<FormFieldState>();
  var lang = "en";

  // StorageHelperController storage = Get.find<StorageHelperController>();
  final storage = GetStorage();

  InitialAppController controller = Get.find<InitialAppController>();
  void initData() async {
    // ignore: prefer_if_null_operators
    var p = Patient.fromJson(jsonDecode(await storage.read('patient') != null
        ? await storage.read('patient')
        : '{}'));

    setState(() {
      patient = p;
      diseaseList = lang == "en"
          ? controller.diseaselist
              .map((item) => MultiSelectItem(item, item.valEn!))
              .toList()
          : controller.diseaselist
              .map((item) => MultiSelectItem(item, item.valAr!))
              .toList();
      midiList = controller.ingredientList != null
          ? controller.ingredientList
              .map((item) => MultiSelectItem(item, item.name!))
              .toList()
          : controller.brandList
              .map((item) => MultiSelectItem(item, item.brandName!))
              .toList();

      name_controller.text = p.name!;
      gender = p.gender!;
      dobController.text = p.dob!.substring(0, 10);
      midi_cotroller = p.chronic_midicens != null ? p.chronic_midicens : [];
      dis_controller = p.chronic_diseases != null ? p.chronic_diseases : [];
      hyper_controller =
          p.drug_hypersensetitvity != null ? p.drug_hypersensetitvity : [];

      midi_cotroller.length > 0
          ? _radioChronicDiseases = 1
          : _radioChronicDiseases = 0;
      hyper_controller.length > 0
          ? _radioAllergyMedication = 1
          : _radioAllergyMedication = 0;
    });
  }

  /*
      Add check for Pateint
   */
  int _radioChronicDiseases = 0;
  String chronicDiseasesType = "None";

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioChronicDiseases = value!;
      switch (_radioChronicDiseases) {
        case 0:
          chronicDiseasesType = "None";
          break;
        case 1:
          chronicDiseasesType = "SelectChronicDiseases";
          break;
      }
    });
  }

  /*
      Add check for Pateint
   */
  int _radioAllergyMedication = 0;
  String allergyMedicationType = "None";

  void _handleRadioValueAllergyMedicationChange(int? value) {
    setState(() {
      _radioAllergyMedication = value!;
      switch (_radioAllergyMedication) {
        case 0:
          allergyMedicationType = "None";
          break;
        case 1:
          allergyMedicationType = "SelectChronicDiseases";
          break;
      }
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
    lang = this.widget.lang;
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
              actions: <Widget>[BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    child: Text(
                        lang == "en" ? 'Patient Profile' : 'معلومات المريض')),
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
                      Container(
                        width: 152,
                        height: 152,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: Color(0xff5C376D),
                        ),
                        child: Center(
                          child: storagectrl.img != ''
                              ? CircleAvatar(
                                  minRadius: 70,
                                  backgroundImage:
                                      NetworkImage(storagectrl.img),
                                  backgroundColor: Colors.grey[900])
                              : CircleAvatar(
                                  minRadius: 70,
                                  backgroundImage:
                                      AssetImage('assets/img/6.png'),
                                  backgroundColor: Colors.grey[900]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                                      ? " Patient Profile "
                                      : "معلومات المريض",
                                  style: TextStyle(
                                      color: Color(0xff5C376D),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                )),
                              ]),
                              SizedBox(height: 10),
                              TextFormField(
                                  controller: name_controller,
                                  onChanged: (val) {
                                    patient?.name = val.toString();
                                    print("ttt ${{patient?.name}}");
                                    var p = patient?.toJson();
                                    print(p);
                                  },
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
                                    hintText: lang == "en" ? 'Name' : 'الأسم',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Your Name';
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () => _selectDate(context),
                                child: IgnorePointer(
                                  child: TextFormField(
                                    controller: dobController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0 +
                                              ((context.diagonalInches / 6.0)
                                                      .floorToDouble() *
                                                  10),
                                          horizontal: 10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2.0),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 2.0)),
                                      hintText: lang == "en"
                                          ? 'Year Of Birth'
                                          : 'سنة الميلاد',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter your date of birth';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2.0, color: Colors.black)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        gender == ''
                                            ? (lang == 'en'
                                                ? 'gender'
                                                : 'الجنس')
                                            : gender,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    PopupMenuButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.black.withOpacity(0.5),
                                          size: 20,
                                        ),
                                        elevation: 1,
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Text(
                                                  "male".tr,
                                                ),
                                                value: 1,
                                                onTap: () {
                                                  setState(() {
                                                    gender = 'male';
                                                  });
                                                },
                                              ),
                                              PopupMenuItem(
                                                child: Text(
                                                  "female".tr,
                                                ),
                                                value: 2,
                                                onTap: () {
                                                  setState(() {
                                                    gender = 'female';
                                                  });
                                                },
                                              ),
                                            ]),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(children: <Widget>[
                                const Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                )),
                                Text(
                                    lang == "en"
                                        ? " Medical Information "
                                        : "المعلومات الطبية",
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
                              Align(
                                alignment: lang == "en"
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Text(
                                  lang == "en"
                                      ? "Do you have chronic diseases ?"
                                      : "هل لديك أمراض مزمنة ؟",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: const Color(0xff5C376D),
                                    value: 0,
                                    groupValue: _radioChronicDiseases,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  Text(
                                    lang == "en" ? "None" : "لا",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  Radio(
                                    activeColor: const Color(0xff5C376D),
                                    value: 1,
                                    groupValue: _radioChronicDiseases,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  Text(
                                    lang == "en" ? "Selection" : "نعم",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Roboto',
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              if (_radioChronicDiseases == 0)
                                Container()
                              else
                                MultiSelectBottomSheetField(
                                    key: _multiSelectKey,
                                    initialChildSize: 0.7,
                                    maxChildSize: 0.95,
                                    initialValue: lang == "en"
                                        ? dis_controller
                                            .map((e) =>
                                                MultiSelectItem(e, e['Val_en']))
                                            .toList()
                                        : dis_controller
                                            .map((e) =>
                                                MultiSelectItem(e, e['Val_ar']))
                                            .toList(),
                                    onSelectionChanged: (val) {
                                      patient?.chronic_diseases = val;
                                      var p = patient?.toJson();
                                      print(p);
                                      setState(() {
                                        // dis_controller.clear();
                                        dis_controller = val;
                                        print(
                                            "dis controller : $dis_controller");
                                      });
                                    },
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: const Border.fromBorderSide(
                                          BorderSide(
                                              color: Colors.black, width: 2.0)),
                                    ),
                                    selectedColor: Color(0xfff5C376D),
                                    title: Text(lang == "en"
                                        ? 'CHRONIC DISEASES'
                                        : 'الأمراض المزمنة'),
                                    buttonText: Text(lang == "en"
                                        ? 'CHRONIC DISEASES'
                                        : 'الأمراض المزمنة'),
                                    items: diseaseList ?? [],
                                    searchable: true,
                                    onConfirm: (values) {
                                      setState(() {
                                        dis_controller = values;
                                      });
                                    },
                                    chipDisplay: MultiSelectChipDisplay.none()),
                              _radioChronicDiseases == 0
                                  ? Container()
                                  : MultiSelectChipDisplay(
                                      items: lang == "en"
                                          ? dis_controller
                                              .map((e) => MultiSelectItem(
                                                  e, e['Val_en']))
                                              .toList()
                                          : dis_controller
                                              .map((e) => MultiSelectItem(
                                                  e, e['Val_ar']))
                                              .toList(),
                                      chipColor:
                                          Color(0xfff5C376D).withOpacity(0.4),
                                    ),
                              SizedBox(height: 10),
                              _radioChronicDiseases == 0
                                  ? Container()
                                  : MultiSelectBottomSheetField(
                                      key: _multiSelect1Key,
                                      initialChildSize: 0.7,
                                      maxChildSize: 0.95,
                                      onSelectionChanged: (val) {
                                        patient?.chronic_midicens = val;
                                        var p = patient?.toJson();
                                        print(p);
                                      },
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: const Border.fromBorderSide(
                                            BorderSide(
                                                color: Colors.black,
                                                width: 2.0)),
                                      ),
                                      selectedColor: Color(0xfff5C376D),
                                      title: Text(lang == "en"
                                          ? 'CHRONIC MEDICINES'
                                          : 'الأدوية المزمنة'),
                                      buttonText: Text(lang == "en"
                                          ? 'CHRONIC MEDICINES'
                                          : 'الأدوية المزمنة'),
                                      items: midiList ?? [],
                                      searchable: true,
                                      onConfirm: (values) {
                                        setState(() {
                                          midi_cotroller = values;
                                        });
                                      },
                                      chipDisplay:
                                          MultiSelectChipDisplay.none()),
                              _radioChronicDiseases == 0
                                  ? Container()
                                  : MultiSelectChipDisplay(
                                      chipColor:
                                          Color(0xfff5C376D).withOpacity(0.4),
                                    ),
                              SizedBox(height: 10),
                              Align(
                                alignment: lang == "en"
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Text(
                                  lang == "en"
                                      ? "Do you have a drug allergy? ?"
                                      : "هل لديك حساسية للأدوية ؟",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: const Color(0xff5C376D),
                                    value: 0,
                                    groupValue: _radioAllergyMedication,
                                    onChanged:
                                        _handleRadioValueAllergyMedicationChange,
                                  ),
                                  Text(
                                    lang == "en" ? "None" : "لا",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  Radio(
                                    activeColor: const Color(0xff5C376D),
                                    value: 1,
                                    groupValue: _radioAllergyMedication,
                                    onChanged:
                                        _handleRadioValueAllergyMedicationChange,
                                  ),
                                  Text(
                                    lang == "en" ? "Select" : "نعم",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Roboto',
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              _radioAllergyMedication == 0
                                  ? Container()
                                  : MultiSelectBottomSheetField(
                                      key: _multiSelect2Key,
                                      initialChildSize: 0.7,
                                      maxChildSize: 0.95,
                                      // initialValue: hyper_controller
                                      //     .map((e) => MultiSelectItem(
                                      //         e,
                                      //         e['Name'] != null
                                      //             ? e['Name']
                                      //             : e['Brand_Name']))
                                      //     .toList(),
                                      onSelectionChanged: (val) {
                                        patient!.drug_hypersensetitvity = val;
                                        var p = patient!.toJson();
                                        print(p);
                                      },
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.fromBorderSide(
                                            BorderSide(
                                                color: Colors.black,
                                                width: 2.0)),
                                      ),
                                      selectedColor: Color(0xfff5C376D),
                                      title: Text(lang == "en"
                                          ? 'DRUG ALLERGY'
                                          : 'الحساسية للأدوية'),
                                      buttonText: Text(lang == "en"
                                          ? 'DRUG ALLERGY'
                                          : 'الحساسية للأدوية'),
                                      items: midiList ?? [],
                                      searchable: true,
                                      onConfirm: (values) {
                                        setState(() {
                                          hyper_controller = values;
                                        });
                                      },
                                      chipDisplay:
                                          MultiSelectChipDisplay.none()),
                              _radioAllergyMedication == 0
                                  ? Container()
                                  : MultiSelectChipDisplay(
                                      items: hyper_controller
                                          .map((e) => MultiSelectItem(
                                              e,
                                              e['Name'] != null
                                                  ? e['Name']
                                                  : e['Brand_Name']))
                                          .toList(),
                                      chipColor:
                                          Color(0xfff5C376D).withOpacity(0.4),
                                    ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            bottomNavigationBar: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
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
