import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/Models/indications_by_brandid.dart';
import 'package:adwiah/Services/brands_service.dart';
import 'package:get/get.dart';

class BrandsController extends GetxController {
  List<BrandByIdModel> brandByI = <BrandByIdModel>[].obs;
  List<IndicationsModel> indications = <IndicationsModel>[].obs;
  BrandService brandService = BrandService();
  // var loadther = false.obs;
  var loadbrandByid = false.obs;
  getbrandByI(String id) async {
    try {
      loadbrandByid.value = false;
      brandByI = await brandService.getBrandsById(id);
      await getindications(id);
      loadbrandByid.value = true;
    } catch (e) {
      print('Errorr $e');
    }
  }

  getindications(String id) async {
    try {
      indications = await brandService.getIndication(id);
    } catch (e) {
      print('Errorr $e');
    }
  }
}
