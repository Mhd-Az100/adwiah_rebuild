import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:flutter/material.dart';

class PatientProfileNotification extends StatefulWidget {
  final lang;

  PatientProfileNotification({Key? key, this.lang}) : super(key: key);

  @override
  _PatientProfileNotificationState createState() =>
      _PatientProfileNotificationState();
}

class _PatientProfileNotificationState
    extends State<PatientProfileNotification> {
  var lang;
  String notificationType = "اليوم";
  List<NotificationModel> _notificationList = [];
  List<NotifyModel> _notifyList = [];

  DateTime todayDate = DateTime.now();

  _getAllNotification() async {
    try {
      _notificationList.clear();
      _notifyList.clear();
      var data = await DatabaseHelper.instance?.getAllNotification() ?? [];

      for (int i = 0; i < data.length; i++) {
        String dateAndTime =
            data[i].date!.substring(0, 10) + " " + data[i].time!;
        DateTime dateTime = DateTime.parse(dateAndTime);
        dateTime.isAfter(todayDate)
            ? _notifyList.add(NotifyModel(data[i].id!, dateTime, data[i].title!,
                data[i].body!, data[i].status!))
            : print("no add date ==========");
      }
      _notifyList.sort((a, b) {
        return a.notifyDate.compareTo(b.notifyDate);
      });
    } on Exception catch (e) {
      // TODO
      print("exception get notification : $e");
    }
  }

  _getTodayNotification() async {
    try {
      _notifyList.clear();
      var data = await DatabaseHelper.instance?.getAllNotification();

      for (int i = 0; i < data!.length; i++) {
        String dateAndTime =
            data[i].date!.substring(0, 10) + " " + data[i].time!;
        DateTime date = DateTime.parse(dateAndTime);
        print("data time  : $date");

        if (date.day == todayDate.day && date.isAfter(todayDate)) {
          setState(() {
            _notifyList.add(NotifyModel(data[i].id!, date, data[i].title!,
                data[i].body!, data[i].status!));
          });
        }
      }
      _notifyList.sort((a, b) {
        return a.notifyDate.compareTo(b.notifyDate);
      });
    } on Exception catch (e) {
      // TODO
      print("exception get notification : $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lang = widget.lang;
    _getTodayNotification();
    notificationType = 'اليوم';
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
                    child: Text(lang == "en" ? 'Notification' : 'الإشعارات')),
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
                                      lang == 'en' ? 'All' : 'الكل',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        color: notificationType == 'الكل'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  height: 45,
                                  onPressed: () {
                                    setState(() {
                                      notificationType = 'الكل';
                                      _getAllNotification();
                                    });
                                  },
                                  color: notificationType == 'الكل'
                                      ? Color(0xff5C376D)
                                      : Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  minWidth: 130,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      lang == 'en' ? 'Today' : 'اليوم',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14,
                                        color: notificationType == 'اليوم'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  height: 45,
                                  onPressed: () {
                                    setState(() {
                                      notificationType = 'اليوم';
                                      _getTodayNotification();
                                    });
                                  },
                                  color: notificationType == 'اليوم'
                                      ? Color(0xff5C376D)
                                      : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Card(
                    elevation: 5.0,
                    margin: EdgeInsets.only(
                      top: 5,
                      bottom: 10,
                    ),
                    shadowColor: Color(0xff5C376D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xff5C376D))),
                        child: ListView.builder(
                            itemCount: _notifyList.length,
                            itemBuilder: (context, index) {
                              return notificationItem(_notifyList[index], index,
                                  _notifyList.length);
                            }),
                      ),
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
          ),
        ],
      ),
    );
  }

  Widget notificationItem(
      NotifyModel notificationModel, int index, int listLength) {
    return Container(
      height: 125,
      child: Row(
        children: [
          Column(
            children: [
              index == 0
                  ? Expanded(
                      child: Container(
                        width: 2,
                        height: 40,
                        color: Colors.white,
                      ),
                    )
                  : Expanded(
                      child: Container(
                        width: 2,
                        height: 40,
                        color: Color(0xff5C376D),
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: notificationModel.status == 1
                        ? Color(0xff5C376D)
                        : Colors.white,
                    border: Border.all(color: Color(0xff5C376D), width: 2.0)),
              ),
              index == listLength - 1
                  ? Expanded(
                      child: Container(
                        width: 2,
                        height: 40,
                        color: Colors.white,
                      ),
                    )
                  : Expanded(
                      child: Container(
                        width: 2,
                        height: 40,
                        color: Color(0xff5C376D),
                      ),
                    ),
            ],
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.grey.shade50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationModel.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                      fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  notificationModel.content,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                      fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      notificationModel.notifyDate.toString().substring(0, 10),
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                    ),
                    Text(
                      notificationModel.notifyDate.toString().substring(11, 16),
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider()
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class NotifyModel {
  int id;
  DateTime notifyDate;
  String title;
  String content;
  int status;

  NotifyModel(this.id, this.notifyDate, this.title, this.content, this.status);
}
