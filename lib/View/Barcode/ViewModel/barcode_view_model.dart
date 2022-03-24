import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/Services/barcode_service.dart';
import 'package:get/get.dart';

class BarcodeController extends GetxController {
  List<BrandByIdModel> brandByBarcode = <BrandByIdModel>[].obs;
  BarcodeService barcodeService = BarcodeService();
  var loadbrandByBarcode = false.obs;
  getbrandByBarc(String code) async {
    try {
      loadbrandByBarcode.value = true;
      brandByBarcode = await barcodeService.getBrandsByBarcode(code);
      loadbrandByBarcode.value = false;
    } catch (e) {
      print('Errorr $e');
    }
  }
}
