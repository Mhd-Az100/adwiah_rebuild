import 'package:adwiah/View/Disease/ViewModel/disease_view_model.dart';
import 'package:adwiah/View/StudyInteractions/ViewModel/interactions_view_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    Get.put(StudyInteractionsController());
    Get.put(DiseaseController());
  }
}
