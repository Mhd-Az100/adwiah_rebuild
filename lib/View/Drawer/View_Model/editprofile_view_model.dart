// ignore_for_file: unnecessary_this

import 'dart:io';
import 'package:adwiah/Services/drawer_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/View/Home/home_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final _drawerService = DrawerService();
  final TextEditingController f_nameController = TextEditingController();
  final TextEditingController l_nameController = TextEditingController();
  final TextEditingController proffision_nameController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> editprofFormKey = GlobalKey<FormState>();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  void fillolddata() async {
    await soragectrl.readinfouser();
    f_nameController.text = soragectrl.f_name.value;
    l_nameController.text = soragectrl.l_name.value;
    phoneNumberController.text = soragectrl.phone;
    proffision_nameController.text = soragectrl.proffision;
  }

  updateuser() async {
    this.editprofFormKey.currentState!.save();
    if (this.editprofFormKey.currentState!.validate()) {
      var response;
      try {
        BotToast.showLoading();
        response = await _drawerService.updateUser(
          f_name: this.f_nameController.text,
          l_name: this.l_nameController.text,
          proffision_name: this.proffision_nameController.text,
          phoneNumber: this.phoneNumberController.text,
        );
        if (response) {
          soragectrl.saveinfouser(
              f_name: f_nameController.text,
              l_name: l_nameController.text,
              proffision: proffision_nameController.text,
              phone: phoneNumberController.text);
          soragectrl.readinfouser();
          Get.off(Home());
        }
      } catch (e) {
      } finally {
        BotToast.closeAllLoading();
      }

      if (response != null) {}
    }
  }

  var file = File('');
  var filenull = true.obs;
  ImagePicker imagePicker = ImagePicker();
  Future imgPick(x) async {
    try {
      final pickedFile = await imagePicker.pickImage(
          source: x, maxWidth: 200.0, maxHeight: 200.0);
      if (pickedFile != null) {
        filenull.value = false;
        file = File(pickedFile.path);
        BotToast.showLoading();
        var res = await _drawerService.uploadImg(img: pickedFile);
        Get.back();
        soragectrl.saveinfouser(img: res);
        update();
        return;
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(e);
    } finally {
      BotToast.closeAllLoading();
    }
  }

//  patchprofile2() async {
//     try {
//       BotToast.showLoading();
//       apiResult = await profileservice.patchprofileData2(
//         name: firstnameController.text,
//         gender: gender.value == '' ? profile.value.gender! : gender.value,
//         birthdate: date.value == ''
//             ? profile.value.date!.substring(0, 10)
//             : date.value,
//         file: file,
//       );
//       if (apiResult.rfreshToken) {
//         if (!apiResult.hasError!) {
//           patch.value = apiResult.data;
//           await getprofile();
//         } else {
//           hasError.value = apiResult.hasError!;
//           massage.value = apiResult.errorMassage!;
//           DialogsUtils.showdialog(
//               m: massage.value,
//               onPressed: () {
//                 Get.back();
//               });
//         }
//         Get.back();
//       } else {
//         patchprofile2();
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       BotToast.closeAllLoading();
//     }
//   }
  @override
  void onInit() {}
}
