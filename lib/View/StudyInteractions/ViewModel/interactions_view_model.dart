// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adwiah/Models/interactions.dart';
import 'package:adwiah/Models/study_interactions.dart';
import 'package:adwiah/Services/studyinteraction_service.dart';
import 'package:adwiah/Widgets/AlphaScroll/ViewModel/alphabet_view_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyInteractionsController extends GetxController {
  List<StudyInteractionsModel> studyBrand = <StudyInteractionsModel>[].obs;
  List<StudyInteractionsModel> studyIng = <StudyInteractionsModel>[].obs;
  List<InteractionModel> interaction = <InteractionModel>[].obs;
  StudyInteractionService studyInteractionService = StudyInteractionService();
  AlphaBetController alphactrl = Get.find<AlphaBetController>();

  // var loadther = false.obs;
  var loadbrandByid = false.obs;
  getStudyIng(String id) async {
    studyIng = [];
    try {
      loadbrandByid.value = false;
      studyIng = await studyInteractionService.getstudyIng(id);
      loadbrandByid.value = true;
    } catch (e) {
      print('Errorr $e');
    }
  }

  getStudyBrand(String id, String routes) async {
    studyBrand = [];
    try {
      studyBrand = await studyInteractionService.getstudyBrand(id, routes);
    } catch (e) {
      print('Errorr $e');
    }
  }

  getInteractions(String id) async {
    interaction = [];
    try {
      BotToast.showLoading();
      interaction = await studyInteractionService.getInteractions(id);
      var interactionEnecode = jsonEncode(interaction);
      return interactionEnecode;
    } catch (e) {
      print('Errorr $e');
    } finally {
      BotToast.closeAllLoading();
    }
  }

  getInteractionsSeverities(String id) async {
    // studyBrand = [];
    // try {
    //   studyBrand = await studyInteractionService.getInteractionsSeverities(id);
    // } catch (e) {
    //   print('Errorr $e');
    // }
  }

  getInteractionsSeveritiesByBrand(String id, String routes) async {
    // studyBrand = [];
    // try {
    //   studyBrand = await studyInteractionService
    //       .getInteractionsSeveritiesByBrand(id, routes);
    // } catch (e) {
    //   print('Errorr $e');
    // }
  }
  getInteractionDetails(String id) async {
    try {
      var interactionDetails =
          await studyInteractionService.getInteractionDetails(id);
      return jsonEncode(interactionDetails);
    } catch (e) {
      print('Errorr $e');
    }
  }

  Map<InteractioObject, bool> selectedIng = {};
  Map<InteractioObject, bool> selectedBrand = {};
  var objectsIng = <InteractioObject>[].obs;
  var objectsBrand = <InteractioObject>[].obs;

  setObjects({var temping, var tempbrand}) {
    if (temping != null) {
      bool v = selectedIng[temping] != null ? selectedIng[temping]! : false;
      if (objectsIng.length < 6) {
        selectedIng[temping] = !v;
      }
    } else {
      bool v =
          selectedBrand[tempbrand] != null ? selectedBrand[tempbrand]! : false;
      if (objectsBrand.length < 6) {
        selectedBrand[tempbrand] = !v;
      }
    }
    getSelectedObjects();
    update();
  }

  void getSelectedObjects() {
    List<InteractioObject> temp = [];
    if (alphactrl.studyIngorTrand.value) {
      selectedIng.forEach((key, value) {
        if (value == true) temp.add(key);
      });

      objectsIng.value = temp;
    } else {
      selectedBrand.forEach((key, value) {
        if (value == true) temp.add(key);
      });

      objectsBrand.value = temp;
    }
    update();
  }

  List<Widget> showSelectedObjects() {
    try {
      List<Widget> l = <Widget>[].obs;
      if (alphactrl.studyIngorTrand.value) {
        objectsIng.value.forEach((element) {
          l.add(InkWell(
              onTap: () {
                selectedIng[element] = !selectedIng[element]!;

                getSelectedObjects();
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: Text(element.name!)),
                        const Icon(Icons.close)
                      ],
                    ),
                  ),
                ),
              )));
        });
      } else {
        objectsBrand.value.forEach((element) {
          l.add(InkWell(
              onTap: () {
                selectedBrand[element] = !selectedBrand[element]!;
                getSelectedObjects();
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: Text(element.name!)),
                        const Icon(Icons.close)
                      ],
                    ),
                  ),
                ),
              )));
        });
      }
      return l;
    } finally {
      update();
    }
  }
}

class InteractioObject {
  String? name, id, rout;

  InteractioObject({this.name, this.id, this.rout = ''});
}
