import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/Models/ing_by_disease.dart';
import 'package:adwiah/Models/similar_disease.dart';
import 'package:adwiah/Services/disease_service.dart';
import 'package:adwiah/View/Brands/ViewModel/brands_view_model.dart';
import 'package:get/get.dart';

class DiseaseController extends GetxController {
  var lang = 'en'.obs;
  DiseaseService diseaseService = DiseaseService();
  List<SimilarDiseaseModel> similarDisease = <SimilarDiseaseModel>[].obs;
  List<IngByDiseaseModel> ingByDisease = <IngByDiseaseModel>[].obs;
  List<BrandByIdModel> brandByIng = <BrandByIdModel>[].obs;
  var loadbrandDisease = true.obs;
  var loadingByDisease = true.obs;
  var loadbrandByIng = true.obs;
  getdiseaseByI(String id) async {
    try {
      loadbrandDisease.value = true;
      similarDisease = await diseaseService.getDiseaseById(id);
      loadbrandDisease.value = false;
    } catch (e) {
      print('Errorr $e');
    }
  }

  getIngByDisease(String id) async {
    try {
      loadingByDisease.value = true;
      ingByDisease = await diseaseService.getIngBydiseaseId(id);
      loadingByDisease.value = false;
    } catch (e) {
      print('Errorr $e');
    }
  }

  getBrandByIng(String id) async {
    try {
      loadbrandByIng.value = true;
      brandByIng = await diseaseService.getBrandByIng(id);
      await Get.find<BrandsController>().getindications(id);
      loadbrandByIng.value = false;
    } catch (e) {
      print('Errorr $e');
    }
  }
}
