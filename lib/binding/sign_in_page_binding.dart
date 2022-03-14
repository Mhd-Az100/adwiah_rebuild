import 'package:adwiah/View/AuthPages/View_Model/sign_in_view_model.dart';
import 'package:adwiah/View/AuthPages/View_Model/sign_up_view_model.dart';
import 'package:get/get.dart';

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
  }
}
