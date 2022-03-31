import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/main.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  // Future<void> configureLocalTimeZone() async {
  //   tz.initializeTimeZones();
  //   final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  //   tz.setLocalLocation(tz.getLocation(timeZoneName));
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // configureLocalTimeZone();
  }

  // void scheduleAlarm(DateTime? scheduledNotificationDateTime,
  //     NotificationModel notificationModel) async {
  //   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  //     'alarm_notif',
  //     'alarm_notif',
  //     // channelDescription: 'Channel for Alarm notification',
  //     icon: 'ic_launcher',
  //     sound: RawResourceAndroidNotificationSound('sound3'),
  //     largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
  //   );

  //   var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
  //       sound: 'sound3',
  //       presentAlert: true,
  //       presentBadge: true,
  //       presentSound: true);
  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     notificationModel.id!,
  //     notificationModel.title,
  //     notificationModel.body,
  //     tz.TZDateTime.from(scheduledNotificationDateTime!, tz.local),
  //     platformChannelSpecifics,
  //     androidAllowWhileIdle: true,
  //     // matchDateTimeComponents: ,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }
}
