import 'package:adwiah/services/auth_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class VerificatioController extends GetxController {
  final _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> verifyFormKey = GlobalKey<FormState>();

  verify() async {
    if (this.verifyFormKey.currentState!.validate()) {
      var response;
      try {
        BotToast.showLoading();

        response = await _authService.verification(
          codeverify: codeController.text,
          email: emailController.text,
        );
        if (response) {}
      } catch (e) {
      } finally {
        BotToast.closeAllLoading();
      }

      if (response != null) {}
    }
  }

  resendcode() async {
    var response;
    try {
      BotToast.showLoading();

      response = await _authService.resendCode(
        email: emailController.text,
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
