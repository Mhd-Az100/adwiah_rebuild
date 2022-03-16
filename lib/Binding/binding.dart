import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/View/AuthPages/View_Model/sign_in_view_model.dart';
import 'package:adwiah/View/AuthPages/View_Model/sign_up_view_model.dart';
import 'package:adwiah/View/DrawerPages/View_Model/changepassword_view_model.dart';
import 'package:adwiah/View/DrawerPages/View_Model/editprofile_view_model.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_app_view_model.dart';
import 'package:get/get.dart';

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageHelperController(), permanent: true);
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(ChangePasswordController());
    Get.put(EditProfileController());
    Get.put(InitialAppController());
  }
}
