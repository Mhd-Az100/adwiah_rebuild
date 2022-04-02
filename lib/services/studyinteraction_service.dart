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
    try {
      List<StudyInteractionsModel> studyIng = [];
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
        return <StudyInteractionsModel>[];
      }
    } catch (e) {
      return <StudyInteractionsModel>[];
    }
  }

  Future getstudyBrand(String id, String routes) async {
    List<StudyInteractionsModel> studyBrand = [];
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

  Future getInteractions(String id) async {
    try {
      List<InteractionModel> interaction = [];
      var response = await _network.get(
          url: 'get_Interactions/$id', token: soragectrl.Token);
      if (response != null) {
        for (var item in response) {
          interaction.add(InteractionModel.fromJson(item));
        }
        return interaction;
      } else {
        var error = response['message'];
        showToast(error);
        return <InteractionModel>[];
      }
    } catch (e) {
      return [];
    }
  }

  Future getInteractionsSeveritiesByBrand(String id, String routes) async {
    try {
      var response = await _network.get(
          url: 'get_Interactions_severities_by_brand_id_route/$id/$routes',
          token: soragectrl.Token);
      if (response != null) {
        // for (var item in response) {
        //   studyBrand.add(StudyInteractionsModel.fromJson(item));
        // }
        return response;
      } else {
        var error = response['message'];
        showToast(error);
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future getInteractionsSeverities(String id) async {
    try {
      var response = await _network.get(
          url: 'get_Interactions_severities/$id', token: soragectrl.Token);
      if (response != null) {
        // for (var item in response) {
        //   studyBrand.add(StudyInteractionsModel.fromJson(item));
        // }
        return response;
      } else {
        var error = response['message'];
        showToast(error);
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future getInteractionDetails(String id) async {
    try {
      var response = await _network.get(
          url: 'get_Interaction_details/$id', token: soragectrl.Token);
      if (response != null) {
        // for (var item in response) {
        //   studyBrand.add(StudyInteractionsModel.fromJson(item));
        // }
        return response;
      } else {
        var error = response['message'];
        showToast(error);
        return "no detailse";
      }
    } catch (e) {
      return [];
    }
  }
}
