// ignore_for_file: non_constant_identifier_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class StorageHelperController extends GetxController {
  final storage = GetStorage();
  final storage2 = FlutterSecureStorage();

  String Token = '';
  var email = ''.obs;
  String password = '';
  var f_name = ''.obs;
  var l_name = ''.obs;
  String phone = '';
  String proffision = '';
  String img = '';
  String country_id = '12';
  saveaccount(String email, String password) async {
    await storage.write('email', email);
    await storage.write('password', password);
  }

  readaccount() {
    email.value = storage.read('email') ?? '';
    password = storage.read('password') ?? '';
  }

  saveinfouser(
      {String? f_name,
      String? l_name,
      String? phone,
      String? proffision,
      String? img}) async {
    await storage.write('f_name', f_name);
    await storage.write('img', img);
    await storage.write('l_name', l_name);
    await storage.write('phone', phone);
    await storage.write('proffision', proffision);
  }

  readinfouser() {
    f_name.value = storage.read('f_name') ?? '';
    l_name.value = storage.read('l_name') ?? '';
    phone = storage.read('phone') ?? '';
    proffision = storage.read('proffision') ?? '';
    img = storage.read('img') ?? '';
  }

  saveToken(String token) async {
    await storage2.write(key: 'token', value: token);
    Token = (await storage2.read(key: 'token'))!;
  }

  saveCountryId(String country_id) async {
    await storage.write('country_id', country_id);
  }

  readCountryId() {
    country_id = storage.read('country_id') ?? '12';
  }

//======================================================//

  @override
  void onInit() {
    readinfouser();
    super.onInit();
  }
}
