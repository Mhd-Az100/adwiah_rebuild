import 'dart:async';
import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/View/AuthPages/logIn_register_view.dart';
import 'package:adwiah/View/Home/home_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:adwiah/View/Map/ViewModel/map_view_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StorageHelperController soragectrl = Get.find<StorageHelperController>();
  final storage2 = FlutterSecureStorage();

  String Token = '';
  initData() async {
    Token = await storage2.read(key: 'token') ?? '';
    Token == '' || Token == null
        ? Timer(
            const Duration(seconds: 3), () => Get.off(LoginRegisterScreen()))
        : Timer(const Duration(seconds: 3), () async {
            await Get.find<InitialAppController>().getIngredientList();
            await Get.find<InitialAppController>().getBrandList();
            await Get.find<InitialAppController>().getDisease();
            Get.find<InitialAppController>().geticons();
            Get.find<InitialAppController>().getabouttexts();
            Get.find<InitialAppController>().getcountries();
            Get.find<InitialAppController>().getMedicianCenters();
            Get.find<InitialAppController>().getPosts();
            Get.find<MapController>().getVersions();
            Get.find<MapController>().getLocations();
            Get.off(Home());
          });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/adwiah_background.png"),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: size.height / 5,
                width: size.width / 1.5,
                child: Image.asset(
                  "assets/images/loading.gif",
                ),
              ),
            ),
          ],
        ));
  }
}
