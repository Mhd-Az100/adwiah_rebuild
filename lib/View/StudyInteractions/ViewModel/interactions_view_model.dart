import 'package:adwiah/Models/study_interactions.dart';
import 'package:adwiah/Services/studyinteraction_service.dart';
import 'package:get/get.dart';

class StudyInteractionsController extends GetxController {
  List<StudyInteractionsModel> studyBrand = <StudyInteractionsModel>[].obs;
  List<StudyInteractionsModel> studyIng = <StudyInteractionsModel>[].obs;
  StudyInteractionService studyInteractionService = StudyInteractionService();
  // var loadther = false.obs;
  var loadbrandByid = false.obs;
  getStudyIng(String id) async {
    try {
      loadbrandByid.value = false;
      studyIng = await studyInteractionService.getstudyIng(id);
      loadbrandByid.value = true;
    } catch (e) {
      print('Errorr $e');
    }
  }

  getStudyBrand(String id, String routes) async {
    try {
      studyBrand = await studyInteractionService.getstudyBrand(id, routes);
    } catch (e) {
      print('Errorr $e');
    }
  }
}
