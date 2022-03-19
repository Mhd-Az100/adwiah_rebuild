import 'package:adwiah/Models/about_texts.dart';
import 'package:adwiah/Models/brand.dart';
import 'package:adwiah/Models/countries.dart';
import 'package:adwiah/Models/iconslist.dart';
import 'package:adwiah/Models/ingredient.dart';
import 'package:adwiah/Models/mediacal_centers.dart';
import 'package:adwiah/Models/posts_news.dart';
import 'package:adwiah/Models/proffisionslist.dart';
import 'package:adwiah/Services/initialapp_service.dart';
import 'package:get/get.dart';

class InitialAppController extends GetxController {
  final initialService = InitialServices();

  List<ProffisionslistModel> proffisionslist = <ProffisionslistModel>[].obs;
  var isEmpty = false.obs;
  getproffisionslist() async {
    try {
      proffisionslist = await initialService.getproffisionlist();

      isEmpty.value = proffisionslist.length == 0 ? true : false;
    } catch (e) {
      print('Errorr $e');
    }
  }

  List<IconsListModel> iconsList = <IconsListModel>[].obs;
  geticons() async {
    try {
      iconsList = await initialService.geticonsList();
    } catch (e) {
      print('Errorr $e');
    }
  }

  List<PostsModel> posts = <PostsModel>[].obs;
  getPosts() async {
    try {
      posts = await initialService.getPostsList();
    } catch (e) {
      print('Errorr $e');
    }
  }

  List<AboutTextModel> aboutTextsList = <AboutTextModel>[].obs;
  getabouttexts() async {
    try {
      aboutTextsList = await initialService.getAboutTexts();
    } catch (e) {
      print('Errorr $e');
    }
  }

  List<MedicalCentersModel> medicalCentersList = <MedicalCentersModel>[].obs;
  getMedicianCenters() async {
    try {
      medicalCentersList = await initialService.getMedicianCenters();
    } catch (e) {
      print('Errorr $e');
    }
  }

  List<IngredientModel> ingredientList = <IngredientModel>[].obs;
  List<String> ingredientNameList = [];
  getIngredientList() async {
    try {
      ingredientList = await initialService.getIngredient();
      ingredientList.forEach((element) {
        ingredientNameList.add(element.name!);
      });
    } catch (e) {
      print('Errorr $e');
    }
  }

  List<BrandModel> brandList = <BrandModel>[].obs;
  getBrandList() async {
    try {
      brandList = await initialService.getBrands();
    } catch (e) {
      print('Errorr $e');
    }
  }

  List<CountriesModel> countriesList = <CountriesModel>[].obs;
  getcountries() async {
    try {
      countriesList = await initialService.getCountries();
    } catch (e) {
      print('Errorr $e');
    }
  }

  @override
  void onInit() {
    getproffisionslist();
  }
}
