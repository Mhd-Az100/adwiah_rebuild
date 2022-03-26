import 'package:adwiah/Models/locations_pharma.dart';
import 'package:adwiah/Models/version_list.dart';
import 'package:adwiah/Services/network_service/network_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class DosageService {
  final NetworkService _network = NetworkService();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  Future getDosageByBrand(String id, String route) async {
    List<LocationsPharmaModel> locationsPharm = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url:
            'get_Dosage_by_brand_Route_DosageForm/$id/${route.toString().replaceAll('.', '_')}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        locationsPharm.add(LocationsPharmaModel.fromJson(item));
      }
      return locationsPharm;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getDosageByIng(String id) async {
    List<VersionListModel> versionList = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_Dosage_by_Ing/$id', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        versionList.add(VersionListModel.fromJson(item));
      }
      return versionList;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
