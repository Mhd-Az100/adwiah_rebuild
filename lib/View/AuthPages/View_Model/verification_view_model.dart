import 'package:adwiah/View/Home/home.dart';
import 'package:adwiah/services/auth_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificatioController extends GetxController {
  final _authService = AuthService();
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> verifyFormKey = GlobalKey<FormState>();

  verify({required String emaill}) async {
    if (verifyFormKey.currentState!.validate()) {
      var response;
      try {
        BotToast.showLoading();

        response = await _authService.verification(
          email: emaill,
          codeverify: codeController.text,
        );
        if (response) {
          Get.to(() => Home());
        }
      } catch (e) {
      } finally {
        BotToast.closeAllLoading();
      }

      if (response != null) {}
    }
  }

  resendcode({required String emaill}) async {
    var response;
    try {
      BotToast.showLoading();

      response = await _authService.resendCode(
        email: emaill,
      );
      print(response);
      if (response) {}
    } catch (e) {
      BotToast.showText(text: '$e', align: Alignment.center);
    } finally {
      BotToast.closeAllLoading();

      if (response != null) {}
    }
  }
}
