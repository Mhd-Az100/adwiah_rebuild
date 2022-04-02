import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/Services/network_service/network_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class BarcodeService {
  final NetworkService _network = NetworkService();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  Future getBrandsByBarcode(String code) async {
    List<BrandByIdModel> brandsByBarcode = [];
    var response = await _network.get(
        url: 'get_brands_by_Barcode/$code/${soragectrl.country_id}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        brandsByBarcode.add(BrandByIdModel.fromJson(item));
      }
      return brandsByBarcode;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
