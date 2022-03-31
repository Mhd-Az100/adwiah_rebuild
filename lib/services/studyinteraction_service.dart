import 'dart:developer';

import 'package:adwiah/Models/interactions.dart';
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
      inspect(studyBrand);
      return studyBrand;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getInteractions(String id) async {
    List<InteractionModel> interaction = [];
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_Interactions/$id', token: soragectrl.Token);
    if (response != null) {
      for (var item in response) {
        interaction.add(InteractionModel.fromJson(item));
      }
      inspect(interaction);
      return interaction;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getInteractionsSeveritiesByBrand(String id, String routes) async {
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_Interactions_severities_by_brand_id_route/$id/$routes',
        token: soragectrl.Token);
    if (response != null) {
      // for (var item in response) {
      //   studyBrand.add(StudyInteractionsModel.fromJson(item));
      // }
      inspect(response);
      return response;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getInteractionsSeverities(String id) async {
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_Interactions_severities/$id', token: soragectrl.Token);
    if (response != null) {
      // for (var item in response) {
      //   studyBrand.add(StudyInteractionsModel.fromJson(item));
      // }
      inspect(response);
      return response;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }

  Future getInteractionDetails(String id) async {
    print(soragectrl.Token);
    var response = await _network.get(
        url: 'get_Interaction_details/$id', token: soragectrl.Token);
    if (response != null) {
      // for (var item in response) {
      //   studyBrand.add(StudyInteractionsModel.fromJson(item));
      // }
      inspect(response);
      return response;
    } else {
      var error = response['message'];
      showToast(error);
      return false;
    }
  }
}
