import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/Models/indications_by_brandid.dart';
import 'package:adwiah/Services/network_service/network_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class BrandService {
  final NetworkService _network = NetworkService();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  Future getBrandsById(String id) async {
    List<BrandByIdModel> brandsById = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_brands_by_brand_id/$id/${soragectrl.country_id}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        brandsById.add(BrandByIdModel.fromJson(item));
      }
      return brandsById;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getIndication(String id) async {
    List<IndicationsModel> indicationList = [];
    var response = await _network.get(
        url: 'get_Indication_Keys/$id', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        indicationList.add(IndicationsModel.fromJson(item));
      }
      return indicationList;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
