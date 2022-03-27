// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:io';

class Helper {


  static const String PlatformIos = "3C5CE5A3-9338-4785-A3AA-0E15715E6CF7";
  static const String PlatformAndroid = "7049794B-4A4A-47C9-B97D-360168A4A1AD";
  static String Code = Platform.isIOS ? PlatformIos : PlatformAndroid;
  static List<String> MultiImei = [];
  static String Imei = "ddf5c0ea83c3952c";
}
