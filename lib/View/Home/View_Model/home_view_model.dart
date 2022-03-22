import 'package:adwiah/View/InitialPages/View_Model/initial_data_view_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.find<InitialAppController>().geticons();
    Get.find<InitialAppController>().getabouttexts();
    Get.find<InitialAppController>().getcountries();
    Get.find<InitialAppController>().getMedicianCenters();
    Get.find<InitialAppController>().getPosts();
    Get.find<InitialAppController>().getIngredientList();
    Get.find<InitialAppController>().getBrandList();
  }
}
