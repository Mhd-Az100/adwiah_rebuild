import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:adwiah/View/Map/ViewModel/map_view_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await Get.find<StorageHelperController>().readToken();
    Get.find<InitialAppController>().geticons();
    Get.find<InitialAppController>().getabouttexts();
    Get.find<InitialAppController>().getcountries();
    Get.find<InitialAppController>().getMedicianCenters();
    Get.find<InitialAppController>().getPosts();
    Get.find<InitialAppController>().getIngredientList();
    Get.find<InitialAppController>().getBrandList();
    Get.find<InitialAppController>().getDisease();
    Get.find<MapController>().getVersions();
    Get.find<MapController>().getLocations();
  }
}
