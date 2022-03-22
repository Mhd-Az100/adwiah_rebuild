// ignore_for_file: unnecessary_this, non_constant_identifier_names

import 'package:adwiah/View/AuthPages/verificaion_view.dart';
import 'package:adwiah/services/auth_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController f_nameController = TextEditingController();
  final TextEditingController l_nameController = TextEditingController();
  final TextEditingController proffision_nameController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  var signup = false.obs;
  var showpass = true.obs;
  var currentJob = ''.obs;
  var accept = false.obs;

  register() async {
    this.signUpFormKey.currentState!.save();
    if (this.signUpFormKey.currentState!.validate()) {
      var response;
      this.signup.value = true;
      try {
        BotToast.showLoading();

        response = await _authService.register(
          f_name: this.f_nameController.text,
          l_name: this.l_nameController.text,
          proffision_name: this.proffision_nameController.text,
          phoneNumber: this.phoneNumberController.text,
          password: this.passwordController.text,
          email: this.emailController.text,
        );
        if (response) {
          Get.off(Verification(this.emailController.text));
        } else {
          BotToast.showText(text: response["message"]);
        }
      } catch (e) {
        this.signup.value = false;
      } finally {
        BotToast.closeAllLoading();
      }

      if (response != null) {
        this.signup.value = false;
      }
    }
  }
}
