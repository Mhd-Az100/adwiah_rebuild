import 'package:adwiah/Models/study_interactions.dart';
import 'package:adwiah/Services/network_service/network_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class StudyInteractionService {
  final NetworkService _network = NetworkService();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  Future getstudyIng(String id) async {
    List<StudyInteractionsModel> studyIng = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'Study_Interaction_ings/$id', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        studyIng.add(StudyInteractionsModel.fromJson(item));
      }
      return studyIng;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getstudyBrand(String id, String routes) async {
    List<StudyInteractionsModel> studyBrand = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url:
            'Study_Interaction_brands_with_Routes/$id/$routes/${soragectrl.country_id}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        studyBrand.add(StudyInteractionsModel.fromJson(item));
      }
      return studyBrand;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
