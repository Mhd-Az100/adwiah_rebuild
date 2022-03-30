import 'dart:convert';
import 'dart:typed_data';
import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/image_view.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sized_context/sized_context.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sqflite/sqflite.dart';

class PatientProfileDoctor extends StatefulWidget {
  final lang;

  PatientProfileDoctor({this.lang = "en"});

  @override
  _PatientProfileDoctorState createState() => _PatientProfileDoctorState();
}

class _PatientProfileDoctorState extends State<PatientProfileDoctor> {
  var _currencies = [];
  var lang = "en";
  var db = DatabaseHelper.instance;
  int visitId = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController specialistyController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController visitDateController = TextEditingController();
  TextEditingController symptomsController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  var labTestsController = [];
  var myFormat = intl.DateFormat('d-MM-yyyy');

  DateTime selectedDate = DateTime.now();

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
                  setState(() {
                    selectedDate = picked;
                    visitDateController.text = myFormat.format(picked);
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
              },
              initialDateTime: DateTime.now(),
              minimumYear: 1900,
              maximumYear: 2100,
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
      lastDate: DateTime(2100),
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
        visitDateController.text = myFormat.format(picked).trim();
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  void _saveData() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var imagesList = jsonEncode(labTestsController);

    try {
      VisitModel _visitModel = VisitModel(
        doctorName:
            _radioDoctor == 0 ? nameController.text : doctorInformation!.name,
        doctorSpec: _radioDoctor == 0
            ? specialistyController.text
            : doctorInformation!.specialization,
        date: visitDateController.text,
        address: _radioDoctor == 0
            ? addressController.text
            : doctorInformation!.address,
        diagnosis: diagnosisController.text,
        listImage: imagesList,
        phoneNumber:
            _radioDoctor == 0 ? phoneController.text : doctorInformation!.phone,
        symptoms: symptomsController.text,
      );
      DoctorModel _doctorModel = DoctorModel(
        name: nameController.text,
        specialization: specialistyController.text,
        address: addressController.text,
        mobile: mobileController.text,
        phone: phoneController.text,
      );
      if (_radioDoctor == 0) {
        var resultSave = await db!.addDoctor(_doctorModel);
        print("save doctor info : $resultSave");
      }
      var result = await db!.addVisit(_visitModel);
      if (result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            // backgroundColor: Utils.bgSnackBarColor,
            content: Text(
          lang == "en" ? "Visit added successfully" : "تم إضافة الزيارة بنجاح",
          style: TextStyle(color: Colors.white),
        )));
        print("save result : $result");
        // Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            // backgroundColor: Utils.bgSnackBarColor,
            content: Text(
          lang == "en"
              ? "An error occurred during the adding process"
              : "حدث خطأ أثناء عملية الإضافة",
          style: TextStyle(color: Colors.white),
        )));
      }
    } on Exception catch (e) {
      // TODO
      print("save visit exception : $e");
    }
  }

  void checkAddData() async {
    VisitModel? visitResult = await DatabaseHelper.instance!.getLastVisit();
    int visitId = visitResult == null ? 0 : visitResult.id! + 1;
    print("visit id :$visitId");

    List<PrescriptionModel> preListResult =
        await DatabaseHelper.instance!.getPrescriptionByVisitId(visitId) ?? [];
    print("Prescription list :$preListResult");
    int? prescriptionId = preListResult.length > 0 ? preListResult[0].id : 0;
    print("prescription id : $prescriptionId");

    List<DrugsModel> drugsListResult = await DatabaseHelper.instance
            ?.getDrugsByPrescriptionId(prescriptionId!) ??
        [];
    print("Drugs list :$drugsListResult");
    int? drugsId = drugsListResult.length > 0 ? drugsListResult[0].id : 0;
    print("drugs id : $drugsId");

    var resultDeleteNotification =
        await DatabaseHelper.instance?.deleteNotificationByDrugsId(drugsId!);
    var resultDeleteDrugs = await DatabaseHelper.instance
        ?.deleteDrugsByPrescriptionId(prescriptionId!);
    var resultDeletePrescription =
        await DatabaseHelper.instance?.deletePrescriptionByVisitId(visitId);

    print("resultDeleteNotification :$resultDeleteNotification");
    print("resultDeleteDrugs :$resultDeleteDrugs");
    print("resultDeletePrescription :$resultDeletePrescription");
  }

  void _getLastVisit() async {
    VisitModel? data = await DatabaseHelper.instance?.getLastVisit();
    print("data : $data");
    if (data != null) {
      print("visit model : ${data.id}");
      visitId = data.id! + 1;
      print("new visit id : $visitId");
    } else {
      visitId = 1;
    }
  }

  /*
      Add check for choose Doctor
   */
  DoctorModel? doctorInformation;
  int _radioDoctor = 0;
  String chooseDoctorType = "new";

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioDoctor = value!;
      switch (_radioDoctor) {
        case 0:
          chooseDoctorType = "new";
          break;
        case 1:
          chooseDoctorType = "old";
          break;
      }
    });
  }

  String doctorName = "";
  List<DoctorModel> _doctorList = <DoctorModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lang = this.widget.lang;
    initData();
    // _getLastVisit();

    // print("patient profile doctor ");
  }

  void initData() async {
    doctorName = lang == "en" ? "Doctor Name" : "اسم الطبيب";

    _doctorList = await DatabaseHelper.instance?.getDoctors() ?? [];
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
                                  Radio(
                                    // activeColor: Utils.primaryColor,
                                    value: 0,
                                    groupValue: _radioDoctor,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  Text(
                                    lang == "en" ? "New" : "جديد",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  Radio(
                                    // activeColor: Utils.primaryColor,
                                    value: 1,
                                    groupValue: _radioDoctor,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  Text(
                                    lang == "en" ? "Select" : "اختيار",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Roboto',
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              _radioDoctor == 0
                                  ? Column(
                                      children: [
                                        TextFormField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 10.0 +
                                                      ((context.diagonalInches /
                                                                  6.0)
                                                              .floorToDouble() *
                                                          10),
                                                  horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0)),
                                              hintText: lang == "en"
                                                  ? 'Doctor Name'
                                                  : 'اسم الطبيب',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please Enter Your Email';
                                              }
                                              return null;
                                            }),
                                        SizedBox(height: 10),
                                        TextFormField(
                                            controller: specialistyController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 10.0 +
                                                      ((context.diagonalInches /
                                                                  6.0)
                                                              .floorToDouble() *
                                                          10),
                                                  horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0)),
                                              hintText: lang == "en"
                                                  ? 'Speciality'
                                                  : "التخصص",
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please Enter Your Email';
                                              }
                                              return null;
                                            }),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            controller: addressController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 10.0 +
                                                      ((context.diagonalInches /
                                                                  6.0)
                                                              .floorToDouble() *
                                                          10),
                                                  horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0)),
                                              hintText: lang == "en"
                                                  ? 'Address'
                                                  : 'العنوان',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please Enter Your Email';
                                              }
                                              return null;
                                            }),
                                        SizedBox(height: 10),
                                        TextFormField(
                                            controller: phoneController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 10.0 +
                                                      ((context.diagonalInches /
                                                                  6.0)
                                                              .floorToDouble() *
                                                          10),
                                                  horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0)),
                                              hintText: lang == "en"
                                                  ? 'Phone Number'
                                                  : 'رقم الهاتف',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please Enter Your Phone Number';
                                              }
                                              return null;
                                            }),
                                        SizedBox(height: 10),
                                        TextFormField(
                                            controller: mobileController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 10.0 +
                                                      ((context.diagonalInches /
                                                                  6.0)
                                                              .floorToDouble() *
                                                          10),
                                                  horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0)),
                                              hintText: lang == "en"
                                                  ? 'Mobile Number'
                                                  : 'رقم الجوال',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please Enter Your Mobile Number';
                                              }
                                              return null;
                                            }),
                                      ],
                                    )
                                  : InputDecorator(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0 +
                                                ((context.diagonalInches / 6.0)
                                                        .floorToDouble() *
                                                    10),
                                            horizontal: 10.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2.0),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0)),
                                        hintText: doctorName,
                                        // lang == "en" ? 'Drugs Name' : "اسم الدواء",
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(doctorName),
                                          isDense: true,
                                          onChanged: (String? s) {
                                            print("drugs name $s");
                                          },
                                          items: _doctorList
                                              .map((DoctorModel value) {
                                            return DropdownMenuItem<String>(
                                              value: value.name,
                                              child: Text(value.name!),
                                              onTap: () {
                                                setState(() {
                                                  doctorName = value.name!;
                                                  doctorInformation = value;
                                                  // print(midiList.indexOf(value));
                                                  // drugsNameIndex = _drugsList.indexOf(value);
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
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
                              Container(
                                child: InkWell(
                                  onTap: () => _selectDate(context),
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      controller: visitDateController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2.0),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0)),
                                        hintText: lang == "en"
                                            ? 'Visit Date'
                                            : 'تاريخ الزيارة',
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
                                        suffixIcon:
                                            Icon(Icons.camera_alt_outlined),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2.0),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0)),
                                        hintText: lang == "en"
                                            ? 'Lab Tests'
                                            : 'التحاليل المخبرية',
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
                                      String base64file = base64Encode(
                                          await image.readAsBytes());
                                      setState(() {
                                        labTestsController
                                            .add({"image": base64file});
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
                                        tag: "image btn ",
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
                                            tag: "image btn ",
                                            imageUrl: bytes,
                                          );
                                        }));
                                      },
                                    ),
                                  );
                                }).toList()),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                  controller: symptomsController,
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
                                    hintText:
                                        lang == "en" ? 'Symptoms' : "الأعراض",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Your Email';
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 10),
                              SizedBox(height: 10),
                              TextFormField(
                                  controller: diagnosisController,
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
                                    hintText:
                                        lang == "en" ? 'Diagnosis' : 'التشخيص',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Your Email';
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 10),
                              Material(
                                  borderRadius: BorderRadius.circular(100),
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        side: BorderSide(
                                            color: Color(0xff5C376D))),
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
                              InkWell(
                                onTap: () {
                                  if (visitId == 0) {
                                    _getLastVisit();
                                  }

                                  print("visit id before move : $visitId");
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             PrescriptionScreen(
                                  //                 lang: lang,
                                  //                 visitId: visitId)));
                                },
                                child: Container(
                                  height: 45 +
                                      ((context.diagonalInches / 6.0)
                                              .floorToDouble() *
                                          15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          // color: Utils.primaryColor,
                                          width: 2.0)),
                                  child: Center(
                                    child: Text(
                                      lang == 'en'
                                          ? 'Add Prescription'
                                          : 'إضافة وصفة',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 22,
                                        // color: Utils.primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
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
