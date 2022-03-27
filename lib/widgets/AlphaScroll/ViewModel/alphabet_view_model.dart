import 'package:adwiah/Models/brand.dart';
import 'package:adwiah/Models/disease.dart';
import 'package:adwiah/Models/ingredient.dart';
import 'package:adwiah/Widgets/AlphaScroll/alphabet_scoll_view.dart';
import 'package:azlistview/azlistview.dart';
import 'package:get/get.dart';

class AlphaBetController extends GetxController {
  var sortbyname = true.obs;
  var studyIngorTrand = true.obs;
  var itemsaz = <AzItem>[].obs;
  void initList(List<IngredientModel>? ingredient, List<BrandModel>? brands,
      List<DiseaseModel>? disease) {
    if (ingredient != null && studyIngorTrand.value) {
      itemsaz.value = ingredient
          .map((item) => AzItem(
              title: item.name,
              tag: sortbyname.value ? item.name![0].toUpperCase() : item.atcId,
              ingredient: item))
          .toList();
      SuspensionUtil.sortListBySuspensionTag(itemsaz);
    } else if (disease != null) {
      itemsaz.value = disease
          .map((item) => AzItem(
              title: item.valEn,
              tag: item.valEn![0].toUpperCase(),
              disease: item))
          .toList();
      SuspensionUtil.sortListBySuspensionTag(itemsaz);
    } else {
      itemsaz.value = brands!
          .map((item) => AzItem(
              title: item.brandName,
              tag: item.brandName![0].toUpperCase(),
              brands: item))
          .toList();
      SuspensionUtil.sortListBySuspensionTag(itemsaz);
    }
  }
}
