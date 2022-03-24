import 'dart:async';
import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/View/AuthPages/logIn_register_view.dart';
import 'package:adwiah/View/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StorageHelperController soragectrl = Get.find<StorageHelperController>();
  @override
  void initState() {
    super.initState();

    soragectrl.Token == '' || soragectrl.Token == null
        ? Timer(
            const Duration(seconds: 3), () => Get.off(LoginRegisterScreen()))
        : Timer(const Duration(seconds: 3), () => Get.off(Home()));
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
