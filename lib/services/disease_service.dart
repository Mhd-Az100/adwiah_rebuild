import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/Models/disease.dart';
import 'package:adwiah/Models/ing_by_disease.dart';
import 'package:adwiah/Models/similar_disease.dart';
import 'package:adwiah/Services/network_service/network_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class DiseaseService {
  final NetworkService _network = NetworkService();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  Future getDiseaseList() async {
    List<DiseaseModel> diseaseList = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_disease_list/null/null/1/${soragectrl.country_id}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        diseaseList.add(DiseaseModel.fromJson(item));
      }
      return diseaseList;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getDiseaseById(String id) async {
    List<SimilarDiseaseModel> diseaseByid = [];
    var response = await _network.get(
        url: 'get_similar_disease/$id/${soragectrl.country_id}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        diseaseByid.add(SimilarDiseaseModel.fromJson(item));
      }
      return diseaseByid;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getIngBydiseaseId(String id) async {
    List<IngByDiseaseModel> ingByDisease = [];
    var response = await _network.get(
        url: 'get_Ings_by_disease/$id/${soragectrl.country_id}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        ingByDisease.add(IngByDiseaseModel.fromJson(item));
      }
      return ingByDisease;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getBrandByIng(String id) async {
    List<BrandByIdModel> brandByIng = [];
    var response = await _network.get(
        url: 'get_brands_by_ing_id/$id/${soragectrl.country_id}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        brandByIng.add(BrandByIdModel.fromJson(item));
      }
      return brandByIng;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
