// ignore_for_file: unnecessary_this

import 'package:adwiah/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final _authService = AuthService();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final GlobalKey<FormState> chngpassFormKey = GlobalKey<FormState>();
  var showPasswd = false.obs;
  @override
  void onInit() {}
}
