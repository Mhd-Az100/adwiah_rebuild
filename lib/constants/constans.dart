import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  static void dialog(String text) {
    Get.defaultDialog(
      title: "",
      middleText: "",
      middleTextStyle: TextStyle(
        fontSize: 0.0,
      ),
      titleStyle: TextStyle(
        fontSize: 0.0,
      ),
      content: Text(
        text,
        style: TextStyle(
          fontFamily: font,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static void looder(String text) {
    Get.defaultDialog(
      title: "",
      middleText: "",
      middleTextStyle: TextStyle(
        fontSize: 0.0,
      ),
      titleStyle: TextStyle(
        fontSize: 0.0,
      ),
      content: CircularProgressIndicator(
        color: purple,
      ),
    );
  }

  static var hint = TextStyle(
    fontFamily: "Cairo",
    color: Color(0xffc4c4c4),
    fontSize: 12,
    letterSpacing: 0.65,
  );
  static var appbar = TextStyle(
    fontFamily: "Cairo",
    fontSize: 20.0,
    color: Colors.black,
    // fontWeight: FontWeight.w400,
  );
  static String font = "Cairo";

  static var toast = TextStyle(
    fontFamily: "Cairo",
    color: Colors.white, fontSize: 20,
    // letterSpacing: 0.65,
    // letterSpacing: 0.65,
  );
  static const cyan = Color(0xFF28AABA);
  static const yallow = Color(0xFFf4b418);
  static const purple = Color(0xff5C376D);
}
