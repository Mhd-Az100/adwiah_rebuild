import 'package:adwiah/Models/ing_therapeutic.dart';
import 'package:adwiah/Models/ingredient_monos.dart';
import 'package:adwiah/Services/ingredient_service.dart';
import 'package:get/get.dart';

class IngredientController extends GetxController {
  List<IngredientMonosModel> ingMonos = <IngredientMonosModel>[].obs;
  List<IngTherapeuticModel> ingTherapeutic = <IngTherapeuticModel>[].obs;
  IngredientService ingredientService = IngredientService();
  var loadther = false.obs;
  var loadsynon = false.obs;
  getingMonos(String id) async {
    try {
      loadsynon.value = false;
      ingMonos = await ingredientService.getingredientMonos(id);
      loadsynon.value = true;
    } catch (e) {
      print('Errorr $e');
    }
  }

  getTherapeutic(String id) async {
    try {
      loadther.value = false;
      ingTherapeutic = await ingredientService.getTherapeutic(id);
      loadther.value = true;
    } catch (e) {
      print('Errorr $e');
    }
  }
}
