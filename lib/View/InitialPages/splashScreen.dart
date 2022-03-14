import 'dart:async';

import 'package:adwiah/View/AuthPages/logIn_register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Get.off(LoginRegisterScreen()),
    );
    super.initState();
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
                  constraints: BoxConstraints.expand(),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/adwiah_background.png"),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            Center(
              child: Container(
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
