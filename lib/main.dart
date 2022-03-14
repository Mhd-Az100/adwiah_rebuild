// import 'package:device_info/device_info.dart';
import 'dart:io';

import 'package:adwiah/View/InitialPages/splashScreen.dart';
import 'package:adwiah/binding/sign_in_page_binding.dart';
import 'package:adwiah/constants/Helper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  //============get device code============//
  Helper.Code = Platform.isIOS ? Helper.PlatformIos : Helper.PlatformAndroid;

  //=======================================//

  //=======get imei in ios=======//! error build when use device_info plugin
  // final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  // var data = await deviceInfoPlugin.iosInfo;
  // Helper.Imei =
  // Platform.isIOS ? data.identifierForVendor : await UniqueIdentifier.serial;
  //============================//

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
