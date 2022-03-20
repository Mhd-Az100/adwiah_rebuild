import 'package:adwiah/Models/ing_therapeutic.dart';
import 'package:adwiah/Models/ingredient_monos.dart';
import 'package:adwiah/Services/network_service/network_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class IngredientService {
  final NetworkService _network = NetworkService();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();

  Future getingredientMonos(String id) async {
    List<IngredientMonosModel> ingredMonosList = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_ingredient_monos_by_ing_id/$id', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        ingredMonosList.add(IngredientMonosModel.fromJson(item));
      }
      return ingredMonosList;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getTherapeutic(String id) async {
    List<IngTherapeuticModel> ingredTherapeuticList = [];
    var response = await _network.get(
        url: 'get_Theraputics_by_Ing_Id/$id', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        ingredTherapeuticList.add(IngTherapeuticModel.fromJson(item));
      }
      return ingredTherapeuticList;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
