import 'dart:convert';
import 'package:adwiah/Constants/Helper.dart';
import 'package:adwiah/Services/network_service/network_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class DrawerService {
  final NetworkService _network = NetworkService();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  Future updateUser({
    required String f_name,
    required String l_name,
    required String phoneNumber,
    required String proffision_name,
  }) async {
    var response = await _network.post(
        url: 'updateuser',
        body: {
          'code': Helper.Code,
          'f_name': f_name,
          'l_name': l_name,
          'mob': phoneNumber,
          'proffision_name': proffision_name,
          'imei': Helper.Imei,
          'email': soragectrl.email.toString(),
        },
        token: soragectrl.Token);

    if (response != null) {
      return true;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future uploadImg({
    required var img,
  }) async {
    String base64file = base64Encode(await img.readAsBytes());
    String fileName = img.path.split("/").last;

    var response = await _network.post(
        url: 'SaveImage',
        body: {
          "user_guid_id": soragectrl.Token,
          "ImgStr": base64file,
          "ImgName": fileName
        },
        token: soragectrl.Token);

    if (response != null) {
      return response['img'];
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
