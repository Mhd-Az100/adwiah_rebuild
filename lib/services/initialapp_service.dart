import 'package:adwiah/Models/about_texts.dart';
import 'package:adwiah/Models/brand.dart';
import 'package:adwiah/Models/countries.dart';
import 'package:adwiah/Models/iconslist.dart';
import 'package:adwiah/Models/ingredient.dart';
import 'package:adwiah/Models/mediacal_centers.dart';
import 'package:adwiah/Models/posts_news.dart';
import 'package:adwiah/Models/proffisionslist.dart';
import 'package:adwiah/Services/network_service/network_service.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class InitialServices {
  final NetworkService _network = NetworkService();
  StorageHelperController soragectrl = Get.find<StorageHelperController>();
  Future geticonsList() async {
    List<IconsListModel> iconslist = [];
    var response =
        await _network.get(url: 'get_icons_list', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        iconslist.add(IconsListModel.fromJson(item));
      }
      return iconslist;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getAboutTexts() async {
    List<AboutTextModel> aboutTexts = [];

    var response =
        await _network.get(url: 'get_freetext', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        aboutTexts.add(AboutTextModel.fromJson(item));
      }
      return aboutTexts;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getMedicianCenters() async {
    List<MedicalCentersModel> medicalCenters = [];
    var response =
        await _network.get(url: 'get_medical_centers', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        medicalCenters.add(MedicalCentersModel.fromJson(item));
      }
      return medicalCenters;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getCountries() async {
    List<CountriesModel> countries = [];
    var response =
        await _network.get(url: 'get_countries', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        countries.add(CountriesModel.fromJson(item));
      }
      return countries;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getPostsList() async {
    List<PostsModel> postsList = [];

    var response = await _network.get(
        url: 'get_posts_list/${soragectrl.country_id}/en',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        postsList.add(PostsModel.fromJson(item));
      }
      return postsList;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getIngredient() async {
    List<IngredientModel> ingredList = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_ingredient_list/null/${soragectrl.country_id}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        ingredList.add(IngredientModel.fromJson(item));
      }
      return ingredList;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getBrands() async {
    List<BrandModel> brandList = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_brands_list/null/${soragectrl.country_id}',
        token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        brandList.add(BrandModel.fromJson(item));
      }
      return brandList;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getproffisionlist() async {
    List<ProffisionslistModel> proffisionslist = [];

    var response = await _network.get(url: 'Geproffisionslist');
    if (response != null) {
      for (var item in response) {
        proffisionslist.add(ProffisionslistModel.fromJson(item));
      }
      return proffisionslist;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
