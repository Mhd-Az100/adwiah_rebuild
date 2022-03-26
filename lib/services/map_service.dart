import 'package:adwiah/Models/locations_pharma.dart';
import 'package:adwiah/Models/version_list.dart';
import 'package:adwiah/Services/network_service/network_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class MapService {
  final NetworkService _network = NetworkService();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  Future getLocationsPharma() async {
    List<LocationsPharmaModel> locationsPharm = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_Lb_Pharmacies_list/null', token: soragectrl.Token);
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

  Future getVersionList() async {
    List<VersionListModel> versionList = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'GetListsVersion/${soragectrl.country_id}',
        token: soragectrl.Token);
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
