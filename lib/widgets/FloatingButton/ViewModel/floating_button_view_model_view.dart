import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/Services/brands_service.dart';
import 'package:adwiah/Services/dosage_service.dart';
import 'package:get/get.dart';

class FloatingButtonController extends GetxController {
  BrandService brandService = BrandService();
  DosageService dosageService = DosageService();
  List<BrandByIdModel> alternitve = <BrandByIdModel>[].obs;
  var loadAlternitve = true.obs;
  getAlternitve({
    String? id,
    String? route,
    String? compositionID,
    String? authorizationID,
    String? countryId,
  }) async {
    try {
      loadAlternitve.value = true;
      alternitve = await brandService.getAlternitveBrands(
        id!,
        route!,
        compositionID!,
        authorizationID!,
      );
      loadAlternitve.value = false;
    } catch (e) {
      print('Errorr $e');
    } finally {
      update();
    }
  }

  getDosageByBrand({
    String? id,
    String? route,
  }) async {
    try {
      loadAlternitve.value = true;
      alternitve = await dosageService.getDosageByBrand(
        id!,
        route!,
      );
      loadAlternitve.value = false;
    } catch (e) {
      print('Errorr $e');
    } finally {
      update();
    }
  }

  getDosageByIng({
    String? id,
  }) async {
    try {
      loadAlternitve.value = true;
      alternitve = await dosageService.getDosageByIng(
        id!,
      );
      loadAlternitve.value = false;
    } catch (e) {
      print('Errorr $e');
    } finally {
      update();
    }
  }
}
