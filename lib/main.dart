// import 'package:device_info/device_info.dart';
import 'dart:async';

// import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/View/Initial/splash_screen.dart';
// import 'package:adwiah/View/PatienProfile/notification_controller.dart';
import 'package:adwiah/binding/binding.dart';
import 'package:adwiah/constants/Helper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// NotificationController notificationController =
//     Get.put(NotificationController());

// void onStart() {
//   WidgetsFlutterBinding.ensureInitialized();

//   final service = FlutterBackgroundService();
//   service.onDataReceived.listen((event) {
//     if (event!["action"] == "setAsForeground") {
//       service.setAsForegroundService();
//       return;
//     }

//     if (event["action"] == "setAsBackground") {}

//     if (event["action"] == "stopService") {
//       service.setAsBackgroundService();
//     }
//   });

//   Timer.periodic(Duration(minutes: 30), (timer) async {
//     if (!(await service.isRunning())) timer.cancel();

//     service.setNotificationInfo(
//       title: "Adwiah",
//       content: "Updated at ${DateTime.now()}",
//     );

//     _getNotification();
//   });
// }

// void _getNotification() async {
//   DateTime myTime = DateTime.now();
//   List<NotificationModel> data =
//       await DatabaseHelper.instance?.getNotificationByStatus() ?? [];

//   for (int i = 0; i < data.length; i++) {
//     DateTime date =
//         DateTime.parse(data[i].date!.substring(0, 10) + " " + data[i].time!);
//     print("date : $date");

//     DateTime dropTime = myTime.add(Duration(minutes: 30));
//     if (myTime.isBefore(date) && date.isBefore(dropTime)) {
//       print("ok ##");
//       print("time now : ${DateTime.now()}");

//       NotificationController().configureLocalTimeZone();
//       NotificationController().scheduleAlarm(date, data[i]);

//       data[i].status = 1;
//       var result = DatabaseHelper.instance?.updateNotification(data[i]);
//       print("update notification : $result");
//     } else {
//       print("no #### ");
//     }
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await GetStorage.init();

  //============get device code and imei============//
  // Helper.Code = Platform.isIOS ? Helper.PlatformIos : Helper.PlatformAndroid;
  try {
    Helper.Imei = await DeviceInformation.deviceIMEINumber;
    print(Helper.Imei);
  } on PlatformException {
    print('Failed to get platform version');
  }

  //=======================================//
  // FlutterSecureStorage();

  // GetStorage().erase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Bind bind = Bind();
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        initialBinding: bind,
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
