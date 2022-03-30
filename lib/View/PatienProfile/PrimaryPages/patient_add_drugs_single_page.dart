// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sized_context/sized_context.dart';

class AddDrugsSinglePage extends StatefulWidget {
  final lang;
  AddDrugsSinglePage({this.lang = "en"});

  @override
  _AddDrugsPageSingleState createState() => _AddDrugsPageSingleState();
}

class _AddDrugsPageSingleState extends State<AddDrugsSinglePage> {
  var lang;
  var loading = true;
  List<dynamic> _drugsList = [];
  List<MultiSelectItem<dynamic>>? _midiList;
  List<dynamic> _drugSelection = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  TextEditingController drugsDateController = new TextEditingController();
  TextEditingController drugsTimeController = new TextEditingController();
  TextEditingController durationController = new TextEditingController();
  TextEditingController takeController = new TextEditingController();
  TextEditingController takeTimeController = new TextEditingController();

  // NotificationController notificationController =
  //     Get.put(NotificationController());

  List<DateClass> _dateList = [];

  String? drugsName;
  String takeType = "قبل الطعام";
  int prescriptionId = 0;
  int _radioValue = 0;
  int drugsNameIndex = 0;
  int drugsDuration = 0;
  int drugsId = 0;
  int numberOfDrugsByDay = 3;
  String drugsTime = "";

  var myFormat = intl.DateFormat('d-MM-yyyy');
  DateTime selectedDate = DateTime.now();

  String? _hour, _minute, _time;
  String? dateTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  List<String> _drugsNameAddList = [];

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
                    drugsDateController.text = myFormat.format(picked);
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
        drugsDateController.text = myFormat.format(picked).trim();
        print("date picked : $picked");
        print("date : ${myFormat.format(picked).trim()}");
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  _selectTime(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialTimePicker(context);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildCupertinoTimePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoTimePicker(context);
    }
  }

  buildCupertinoTimePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (picked) {
                if (picked != null)
                  setState(() {
                    selectedTime = TimeOfDay.fromDateTime(picked);
                    drugsDateController.text = myFormat.format(picked);

                    _hour = (selectedTime.hour >= 0 && selectedTime.hour < 10)
                        ? "0" + selectedTime.hour.toString()
                        : selectedTime.hour.toString();
                    _minute =
                        (selectedTime.minute >= 0 && selectedTime.minute < 10)
                            ? "0" + selectedTime.minute.toString()
                            : selectedTime.minute.toString();

                    _time = _hour! + ' : ' + _minute!;
                    drugsTimeController.text = _time!;
                    drugsTime = _hour! + ":" + _minute!;
                    print("drugs time : $drugsTime");
                    // drugsTimeController.text = formatDate(
                    //     DateTime(2019, 08, 1, selectedTime.hour,
                    //         selectedTime.minute),
                    //     [hh, ':', nn, " ", am]).toString();
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

  buildMaterialTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = (selectedTime.hour >= 0 && selectedTime.hour < 10)
            ? "0" + selectedTime.hour.toString()
            : selectedTime.hour.toString();
        _minute = (selectedTime.minute >= 0 && selectedTime.minute < 10)
            ? "0" + selectedTime.minute.toString()
            : selectedTime.minute.toString();

        _time = _hour! + ' : ' + _minute!;
        drugsTimeController.text = _time!;
        drugsTime = _hour! + ":" + _minute!;
        print("drugs time : $drugsTime");
        // drugsTimeController.text = formatDate(
        //     DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
        // [hh, ':', nn, " ", am]).toString();
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;
      switch (_radioValue) {
        case 0:
          takeType = "قبل الطعام";
          break;
        case 1:
          takeType = "بعد الطعام";
          break;
        case 2:
          takeType = "غير ذلك";
          break;
      }
    });
  }

  _saveData() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (drugsDateController.text.isNotEmpty &&
        drugsTimeController.text.isNotEmpty &&
        durationController.text.isNotEmpty) {
      // try {
      var result = await DatabaseHelper.instance!.addDrugs(DrugsModel(
          name: drugsName,
          take: _radioValue == 2 ? takeController.text : takeType,
          date: drugsDateController.text,
          time: drugsTimeController.text,
          duration: durationController.text,
          presId: 0));
      if (result > 0) {
        drugsId = result;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff5C376D),
            content: Text(
              lang == "en"
                  ? "Drugs added successfully"
                  : "تم إضافة الدواء بنجاح",
              style: TextStyle(color: Colors.white),
            )));
        drugsDuration = int.parse(durationController.text);

        setState(() {
          _drugsNameAddList.add(drugsName!);
          // _drugsList.removeAt(drugsNameIndex);
        });
        // _drugsList.clear();
        print("add notification :$result");
        _addNotification(result);
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
      // } on Exception catch (e) {
      //   print("save drugs : $e");
      // }
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

  _addNotification(int drugId) {
    for (int i = 0; i < drugsDuration; i++) {
      var newDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day + i,
      );
      int durationDay =
          _radioValue == 2 ? int.parse(takeTimeController.text) : 3;
      print("duration time by day : $durationDay");
      double otherDelay =
          _radioValue == 2 ? 24 / int.parse(takeTimeController.text) : 0;
      print("time divide : $durationDay");
      int hourDelay = _radioValue == 2 ? otherDelay.toInt() : 8;
      print("hour delay : $hourDelay");

      var dateNow = DateTime.now();
      var newDateTime = DateTime(dateNow.year, dateNow.month, dateNow.day,
          selectedTime.hour, selectedTime.minute);

      for (int j = 0; j < durationDay; j++) {
        newDateTime =
            j == 0 ? newDateTime : newDateTime.add(Duration(hours: hourDelay));
        print("new date after add : $newDateTime");
        String newHour = (newDateTime.hour >= 0 && newDateTime.hour < 10)
            ? "0" + newDateTime.hour.toString()
            : newDateTime.hour.toString();
        String newMinute = (newDateTime.minute >= 0 && newDateTime.minute < 10)
            ? "0" + newDateTime.minute.toString()
            : newDateTime.minute.toString();
        ;
        print("new date after add : $newHour:$newMinute");
        _dateList.add(DateClass(
            newDate.toString(),
            "$newHour:$newMinute",
            drugsName!,
            _radioValue == 2 ? takeController.text : takeType,
            drugId));
      }
    }

    print("### Done generate Dates");

    for (int i = 0; i < _dateList.length; i++) {
      var result = DatabaseHelper.instance!.addNotification(NotificationModel(
        time: _dateList[i].time,
        date: _dateList[i].date,
        title: _dateList[i].drugsName,
        body: _dateList[i].takeType,
        drugsId: _dateList[i].drugId,
        drugData: "",
        status: 0,
      ));
      print("result  $i  : $result");
    }
    print("### Done add notification");
    durationController.clear();
    drugsDateController.clear();
    drugsTimeController.clear();
    takeController.clear();
    takeTimeController.clear();

    _addDrugsLocalNotification(drugId);
  }

  _addDrugsLocalNotification(int drugsId) async {
    List<NotificationModel> data =
        await DatabaseHelper.instance!.getNotificationByStatus() ?? [];

    print("list of notification : $data");

    for (int i = 0; i < data.length; i++) {
      DateTime myTime = DateTime.now();
      DateTime date =
          DateTime.parse(data[i].date!.substring(0, 10) + " " + data[i].time!);
      print("date : $date");
      DateTime dropTime = myTime.add(Duration(minutes: 30));
      if (myTime.isBefore(date) && date.isBefore(dropTime)) {
        print("yes its notify :##");
        print("time now : ${DateTime.now()}");

        // NotificationController().configureLocalTimeZone();
        // NotificationController().scheduleAlarm(date, data[i]);
        data[i].status = 1;
        var result = DatabaseHelper.instance!.updateNotification(data[i]);
      } else {
        // print("no equal ");
        print("no #### ");
      }
    }
  }

  void initData() async {
    // var tnList = jsonDecode(await storage.read(key: 'brandList'));
    // //
    // List midi = tnList;
    // setState(() {
    //   _midiList = midi
    //       .map((item) => MultiSelectItem(
    //           item, item['Name'] != null ? item['Name'] : item['Brand_Name']))
    //       .toList();
    //   print("list  of drugs : $tnList");
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
    lang = widget.lang;
    lang == "en" ? drugsName = 'Drugs Name' : drugsName = "اسم الدواء";
    print("presentId $prescriptionId");
    print("list drugs : $_drugsList");
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
              actions: [BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child:
                    FittedBox(child: Text(lang == "en" ? 'Drugs' : 'الأدوية')),
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
                        MultiSelectBottomSheetField(
                          key: _multiSelectKey,
                          initialChildSize: 0.7,
                          maxChildSize: 0.95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.black, width: 2.0)),
                          ),
                          selectedColor: Color(0xfff5C376D),
                          title: Text(lang == "en"
                              ? 'Chose medicine from the list'
                              : 'اختر من قائمة الأدوية'),
                          buttonText: Text(lang == "en"
                              ? 'Chose medicine from the list'
                              : 'اختر من قائمة الأدوية'),
                          items: _midiList ?? [],
                          searchable: true,
                          validator: (values) {
                            if (values == null || values.isEmpty) {
                              return "Required";
                            }
                            // List<String> names =
                            //     values.map((e) => e.name).toList();
                            // if (names.contains("Frog")) {
                            //   return "Frogs are weird!";
                            // }
                            return null;
                          },
                          onConfirm: (values) {
                            print(values);
                            setState(() {
                              _drugSelection = values;
                            });
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            onTap: (item) {},
                          ),
                        ),

                        SizedBox(height: 10),
                        InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0 +
                                    ((context.diagonalInches / 6.0)
                                            .floorToDouble() *
                                        10),
                                horizontal: 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
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
                              hint: Text(drugsName!),
                              isDense: true,
                              onChanged: (String? s) {
                                print("drugs name $s");
                              },
                              items: _drugSelection.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value['Brand_Name'].toString(),
                                  child: Text(value['Brand_Name'].toString()),
                                  onTap: () {
                                    setState(() {
                                      drugsName =
                                          value['Brand_Name'].toString();
                                      // print(midiList.indexOf(value));
                                      // drugsNameIndex = _drugsList.indexOf(value);
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
                        // TextFormField(
                        //     decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.symmetric(
                        //           vertical: 10.0 +
                        //               ((context.diagonalInches / 6.0)
                        //                       .floorToDouble() *
                        //                   10),
                        //           horizontal: 10.0),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide:
                        //             BorderSide(color: Colors.black, width: 2.0),
                        //       ),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //           borderSide: BorderSide(
                        //               color: Colors.black, width: 2.0)),
                        //       hintText: lang == "en"
                        //           ? 'Photocopy of prescription'
                        //           : 'نسخة عن الوصفة',
                        //     ),
                        //     validator: (value) {
                        //       if (value!.isEmpty) {
                        //         return 'Please Enter Your Email';
                        //       }
                        //       return null;
                        //     }),
                        Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          )),
                          Text(lang == "en" ? " Take Type " : "طريقة الأخذ",
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
                        Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: Color(0xff5C376D),
                                  value: 0,
                                  groupValue: _radioValue,
                                  onChanged: _handleRadioValueChange,
                                ),
                                Text(
                                  lang == "en" ? "Before food" : "قبل الطعام",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Color(0xff5C376D),
                                  value: 1,
                                  groupValue: _radioValue,
                                  onChanged: _handleRadioValueChange,
                                ),
                                Text(
                                  lang == "en" ? "After food" : "بعد الطعام",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Color(0xff5C376D),
                                  value: 2,
                                  groupValue: _radioValue,
                                  onChanged: _handleRadioValueChange,
                                ),
                                Text(
                                  lang == "en" ? "Other" : "غير ذلك",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        _radioValue == 2
                            ? Column(
                                children: [
                                  TextFormField(
                                      controller: takeController,
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
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 10,
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
                                      controller: takeTimeController,
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
                                              color: Colors.black, width: 2.0),
                                        ),
                                        hintText: lang == "en"
                                            ? 'How many times a day'
                                            : 'عدد المرات في اليوم',
                                      ),
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Your Email';
                                        }
                                        return null;
                                      }),
                                ],
                              )
                            : Container(),

                        Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          )),
                          Text(lang == "en" ? " Dose Time " : "وقت الجرعة",
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
                        Text(lang == "en"
                            ? 'Save take times at calender and set alarms'
                            : 'احفظ الأوقات الى التقويم و اضبط التنبيهات'),
                        SizedBox(
                          height: 10,
                        ),
                        // TableCalendar(
                        //   calendarController: cal,
                        //   startDay: DateTime.utc(2010, 10, 16),
                        //   endDay: DateTime.utc(2030, 3, 14),
                        // ),
                        Container(
                          child: InkWell(
                            onTap: () => _selectDate(context),
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: drugsDateController,
                                decoration: InputDecoration(
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
                                        ? 'Start Date'
                                        : 'تاريخ البداية',
                                    suffixIcon: Icon(Icons.date_range)),
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
                        SizedBox(height: 10),
                        Container(
                          child: InkWell(
                            onTap: () => _selectTime(context),
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: drugsTimeController,
                                decoration: InputDecoration(
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
                                    hintText: lang == "en" ? 'Time' : 'الوقت',
                                    suffixIcon: Icon(Icons.timer)),
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
                        SizedBox(height: 10),
                        TextFormField(
                            controller: durationController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0 +
                                      ((context.diagonalInches / 6.0)
                                              .floorToDouble() *
                                          10),
                                  horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              hintText:
                                  lang == "en" ? 'Days Duration' : 'مدة العلاج',
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
            bottomNavigationBar: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
                child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: BottomControllBar(0))),
          )
        ],
      ),
    );
  }
}

class DateClass {
  String date;

  String time;

  String drugsName;
  String takeType;
  int drugId;

  DateClass(this.date, this.time, this.drugsName, this.takeType, this.drugId);
}
