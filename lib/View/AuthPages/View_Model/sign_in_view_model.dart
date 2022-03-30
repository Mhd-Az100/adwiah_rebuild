// ignore_for_file: unnecessary_this

import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/View/AuthPages/verificaion_view.dart';
import 'package:adwiah/View/Home/home.dart';
import 'package:adwiah/constants/constans.dart';
import 'package:adwiah/models/login.dart';
import 'package:adwiah/services/auth_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class SignInController extends GetxController {
  final _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  var loggingIn = false.obs;
  var save = true.obs;
  var isLoading = true.obs;
  var showpass = true.obs;
  LoginModel? loginData;
  login() async {
    this.signInFormKey.currentState!.save();
    if (this.signInFormKey.currentState!.validate()) {
      this.loggingIn.value = true;
      try {
        BotToast.showLoading();
        loginData = await _authService.loginWithEmail(
          email: this.emailController.text,
          password: this.passwordController.text,
        );
        isLoading(false);
        if (loginData != null) {
          this.loggingIn.value = false;
          if (loginData!.success!) {
            soragectrl.saveToken(loginData!.userGuidId!);

            soragectrl.saveinfouser(
                f_name: loginData!.fName!,
                l_name: loginData!.lName!,
                phone: loginData!.mob!,
                proffision: loginData!.proffisionName!,
                img: loginData!.imageUrl);
            save.value
                ? soragectrl.saveaccount(
                    emailController.text, passwordController.text)
                : soragectrl.saveaccount('', '');
            loginData!.status == 1
                ? Get.to(() => Home())
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

  @override
  void onInit() async {
    await soragectrl.readaccount();
    emailController.text = soragectrl.email.value;
    passwordController.text = soragectrl.password;
  }
}
