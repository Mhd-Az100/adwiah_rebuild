import 'package:adwiah/Models/locations_pharma.dart';
import 'package:adwiah/Models/version_list.dart';
import 'package:adwiah/Services/map_service.dart';
import 'package:get/get.dart';

class MapController extends GetxController {
  var lang = 'en'.obs;
  MapService mapService = MapService();
  List<LocationsPharmaModel> locations = <LocationsPharmaModel>[].obs;
  List<VersionListModel> versionList = <VersionListModel>[].obs;
  var loadLocations = true.obs;

  getLocations() async {
    try {
      loadLocations.value = true;
      locations = await mapService.getLocationsPharma();
      loadLocations.value = false;
    } catch (e) {
      print('Errorr $e');
    }
  }

  getVersions() async {
    try {
      versionList = await mapService.getVersionList();
    } catch (e) {
      print('Errorr $e');
    }
  }
}
