// import 'package:device_info/device_info.dart';
import 'package:adwiah/View/InitialPages/splash_screen.dart';
import 'package:adwiah/binding/binding.dart';
import 'package:adwiah/constants/Helper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

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
