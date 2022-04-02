import 'package:adwiah/View/AuthPages/logIn_register_view.dart';
import 'package:adwiah/constants/Helper.dart';
import 'package:adwiah/constants/constans.dart';
import 'package:adwiah/models/login.dart';
import 'package:adwiah/services/network_service/network_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

///
///Service Responsible for authentication operations
///
class AuthService {
  final NetworkService _network = NetworkService();
  Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    LoginModel? loginRespons;

    var response = await _network.get(
      url: 'get_token/${Helper.Code}/$email/$password',
    );
    if (response != null && response["success"] == true) {
      loginRespons = LoginModel.fromJson(response);

      return loginRespons;
    } else {
      Constants.dialog(response["message"].toString());

      return false;
    }
  }

  Future register({
    required String f_name,
    required String l_name,
    String? email,
    required String phoneNumber,
    required String proffision_name,
    required password,
  }) async {
    var response = await _network.post(url: 'CreateUser', body: {
      'code': Helper.Code,
      'email': email,
      'password': password,
      'f_name': f_name,
      'l_name': l_name,
      'mob': phoneNumber,
      'proffision_name': proffision_name,
      'imei': Helper.Imei
    });
    if (response != null && response["success"] == true) {
      return true;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future forgetpassword({
    required String phoneNumber,
    String? number,
  }) async {
    var response = await _network.post(
      url: 'user/forgot',
      body: {
        "email": number == null ? phoneNumber : number,
      },
    );
    if (response != null) {
      Get.defaultDialog(
        titlePadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        title: response["msg"].toString(),
        middleText: "",
        middleTextStyle: TextStyle(
          fontFamily: Constants.font,
          fontSize: 0.1,
          letterSpacing: 0.65,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        titleStyle: TextStyle(
          fontFamily: Constants.font,
          fontSize: 24.0,
          letterSpacing: 0.65,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      );
      Future.delayed(Duration(seconds: 6), () {
        Get.off(LoginRegisterScreen());
      });

      return true;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future verification({
    required String codeverify,
    required String email,
  }) async {
    LoginModel? loginRespons;
    var response = await _network.get(
        url: 'activate_new_account/${Helper.Code}/$email/$codeverify');
    if (response != null) {
      loginRespons = LoginModel.fromJson(response);
      // fetchUserNameandPhoneNumber();
      BotToast.showText(text: '$response', align: Alignment.center);
      return loginRespons;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future resendCode({
    required String email,
  }) async {
    var response = await _network.get(
        url: 'resend_verification_code/${Helper.Code}/$email');
    if (response != null) {
      BotToast.showText(text: '$response', align: Alignment.center);
      return true;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future newpassword({
    required String code,
    required String password,
  }) async {
    var response = await _network.post(
      url: 'reset_password',
      body: {
        "code": code,
        "new_password": password,
      },
    );
    if (response != null) {
      return true;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
