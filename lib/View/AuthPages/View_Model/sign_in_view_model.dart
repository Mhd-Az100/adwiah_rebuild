// ignore_for_file: unnecessary_this

import 'package:adwiah/View/AuthPages/verificaion_view.dart';
import 'package:adwiah/View/Home/home.dart';
import 'package:adwiah/constants/constans.dart';
import 'package:adwiah/models/login.dart';
import 'package:adwiah/services/auth_service.dart';
import 'package:adwiah/services/network_service/network_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class SignInController extends GetxController {
  final _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  var loggingIn = false.obs;
  var isPasswordHidden = true.obs;

  var isLoading = true.obs;
  var g = NetworkService();

  login() async {
    this.signInFormKey.currentState!.save();
    if (this.signInFormKey.currentState!.validate()) {
      LoginModel? response;
      this.loggingIn.value = true;
      try {
        BotToast.showLoading();
        response = await _authService.loginWithEmail(
          email: this.emailController.text,
          password: this.passwordController.text,
        );
        isLoading(false);
        if (response != null) {
          this.loggingIn.value = false;
          if (response.success!) {
            response.status == 0
                ? Get.to(() => const Home())
                : Get.to(Verification(this.emailController.text));
          }
        }
      } catch (e) {
        this.loggingIn.value = false;
        showToast("   error  $e",
            textStyle: Constants.toast,
            textAlign: TextAlign.center,
            textPadding: const EdgeInsets.all(10));
      } finally {
        BotToast.closeAllLoading();
      }
    }
  }
}
