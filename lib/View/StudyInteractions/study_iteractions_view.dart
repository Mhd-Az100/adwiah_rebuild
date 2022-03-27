// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';

import 'package:adwiah/Constants/constans.dart';
import 'package:adwiah/Models/study_interactions.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:adwiah/View/StudyInteractions/Components/studyTnteractions_topbar.dart';
import 'package:adwiah/View/StudyInteractions/ViewModel/interactions_view_model.dart';
import 'package:adwiah/Widgets/AlphaScroll/alphabet_scoll_view.dart';
import 'package:adwiah/Widgets/AlphaScroll/ViewModel/alphabet_view_model.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/card_list_search_widget.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InteractioObject {
  final name, id, rout;
  InteractioObject(this.name, this.id, {this.rout = ''});
}

class StudyInteractions extends StatelessWidget {
  InitialAppController initctrl = Get.find<InitialAppController>();
  AlphaBetController alphactrl = Get.find<AlphaBetController>();
  StudyInteractionsController studyctrl =
      Get.put(StudyInteractionsController());
  Map<InteractioObject, bool> selectedIngsids = {};
  Map<InteractioObject, bool> selectedBrands = {};
  @override
  void show({List<StudyInteractionsModel>? res, context}) async {
    List<Widget> text = [];
    if (res != null) {
      for (var i = 0; i < res.length; i += 1) {
        if (res[i].note == null || res[i].note == "") {
          (res[i].ingBWithName != null && res[i].ingBWithName != '') ||
                  (res[i].ingAName != '' && res[i].ingAName != null)
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (TextSpan(
                        children: [
                          TextSpan(
                              text: res[i].ingBWithName != null
                                  ? res[i].ingAName
                                  : res[i].ingAName,
                              style: const TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          const TextSpan(
                              text: ' interact with ',
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: res[i].ingBWithName != null
                                  ? res[i].ingBWithName
                                  : res[i].ingBName,
                              style: const TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          const TextSpan(
                              text: ' as the following : ',
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400))
                        ],
                        style: const TextStyle(
                            height: 1.5,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w400))),
                  ])))
              : null;

          res[i].severityLevel != null &&
                  res[i].severityLevel.toString().contains('contraindicated')
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i].severityLevel != null && res[i].severityLevel != ''
                        ? TextSpan(children: [
                            const TextSpan(
                                text: 'Severity Level : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i].severityLevel,
                                style: const TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : const TextSpan(text: '')),
                  ])))
              : null;
          res[i].interActionType != null && res[i].interActionType != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i].interActionType != null &&
                            res[i].interActionType != ''
                        ? TextSpan(children: [
                            const TextSpan(
                                text: 'InterAction Type  : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i].interActionType,
                                style: const TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;
          res[i].recommendationText != null && res[i].recommendationText != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i].recommendationText != null &&
                            res[i].recommendationText != ''
                        ? TextSpan(children: [
                            const TextSpan(
                                text: 'Recommendation : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i].recommendationText,
                                style: const TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;

          res[i].moreInfoText != null && res[i].moreInfoText != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i].moreInfoText != null && res[i].moreInfoText != ''
                        ? TextSpan(children: [
                            const TextSpan(
                                text: 'More Infos : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i].moreInfoText,
                                style: const TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : TextSpan(text: '')),
                  ])))
              : null;

          res[i].nointeraction != null && res[i].nointeraction != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i].nointeraction != null && res[i].nointeraction != ''
                        ? TextSpan(children: [
                            const TextSpan(
                                text: 'No Interaction : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i].nointeraction,
                                style: const TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : const TextSpan(text: '')),
                  ])))
              : null;
        } else {
          text.add(RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                (TextSpan(
                    children: [
                      TextSpan(
                          text: res[i].ingBWithName != null
                              ? res[i].ingBWithName
                              : res[i].ingAName,
                          style: const TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      const TextSpan(
                          text: ' interact with ',
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: res[i].ingBWithName != null
                              ? res[i].ingBWithName
                              : res[i].ingBName,
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      const TextSpan(
                          text: ' as the following : ',
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                    ],
                    style: const TextStyle(
                        height: 1.5,
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400))),
              ])));

          text.add(RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                (res[i].severityLevel != null
                    ? TextSpan(children: [
                        const TextSpan(
                            text: 'Severity Level : ',
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                        TextSpan(
                            text: res[i].severityLevel,
                            style: const TextStyle(
                                height: 1.5,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w400))
                      ])
                    : TextSpan(text: '')),
              ])));

          text.add(RichText(
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                (TextSpan(children: [
                  const TextSpan(
                      text: 'Note : ',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                  TextSpan(
                      text: res[i].note,
                      style: const TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w400))
                ])),
              ])));

          res[i].nointeraction != null && res[i].nointeraction != ''
              ? text.add(RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    (res[i].nointeraction != null && res[i].nointeraction != ''
                        ? TextSpan(children: [
                            const TextSpan(
                                text: 'No Interaction : ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: res[i].nointeraction,
                                style: const TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ])
                        : const TextSpan(text: '')),
                  ])))
              : null;
        }
      }
    } else {
      text.add(RichText(
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textAlign: TextAlign.center,
          text: const TextSpan(
              text: 'No Interactions found between chosen drugs',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 17,
                  fontWeight: FontWeight.w400))));
    }
    Navigator.pop(context);
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              height: text.length > 1 ? 600 : 200,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Material(
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              child: Text(
                            'Study Result',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )),
                          IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                      // Expanded(child: DosageDetails(text)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void getStudyInteractions(context) async {
    if (alphactrl.studyIngorTrand.value) {
      String ids = '';
      selectedIngsids.forEach((key, value) {
        if (selectedIngsids[key]!) {
          ids += key.id.toString() + ',';
        }
      });
      if (ids != null && ids.isNotEmpty) {
        ids = ids.substring(0, ids.length - 1);
      }
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Study interactions ......'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const [
                  Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffed5565))),
                  ),
                ],
              ),
            ),
          );
        },
      );
      await studyctrl.getStudyIng(ids);
      show(res: studyctrl.studyIng, context: context);
    } else {
      String ids = '', routes = '';
      selectedBrands.forEach((key, value) {
        if (selectedBrands[key]!) {
          ids += key.id.toString() + ',';
          routes += key.rout.toString() + ';';
        }
      });
      if (ids != null && ids.isNotEmpty) {
        ids = ids.substring(0, ids.length - 1);
      }
      if (routes != null && routes.isNotEmpty) {
        routes = routes.substring(0, routes.length - 1);
      }
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Study interactions ......'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const [
                  Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffed5565))),
                  ),
                ],
              ),
            ),
          );
        },
      );
      await studyctrl.getStudyBrand(ids, routes);
      show(res: studyctrl.studyBrand, context: context);
    }
  }

  //=====================================================================
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(height: 250, child: Header2()),
          Scaffold(
            backgroundColor: Colors.transparent,
            drawer: NavDrawer(),
            body: Stack(
              children: [
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    title: Text("Study Interactions",
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        style: const TextStyle(fontSize: 24)),
                    // actions: <Widget>[BarcodeReader(mode: 1)],
                  ),
                  drawer: NavDrawer(),
                  body: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Stack(children: <Widget>[
                      Column(
                        children: <Widget>[
                          StudyInteractionsTopBar(),
                          const SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: RichText(
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Red Color For ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff1c2340)),
                                  ),
                                  TextSpan(
                                    text: 'Synonyms',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.red[800]),
                                  ),
                                ]),
                              )),
                            ),
                          ),
                          GetX<StudyInteractionsController>(
                            builder: (c) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Wrap(
                                      children: c.showSelectedObjects(),
                                    )),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Obx(() {
                            if (alphactrl.studyIngorTrand.value) {
                              return initctrl.onsearch.value
                                  ? (initctrl.listSearchIng.isNotEmpty
                                      ? Expanded(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  initctrl.listSearchIng.length,
                                              itemBuilder: (context, index) {
                                                return CardListSearch(
                                                    ontap: () {},
                                                    ingredient: initctrl
                                                        .listSearchIng[index]);
                                              }),
                                        )
                                      : const Center(
                                          child: Text(
                                            'not found !',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontFamily: 'cairo',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ))
                                  : Expanded(
                                      child: AlphabetScrollPage(
                                        ingredient: initctrl.ingredientList,
                                        className: "study_ing",
                                      ),
                                    );
                            } else {
                              return initctrl.onsearch.value
                                  ? (initctrl.listSearchBrand.isNotEmpty
                                      ? Expanded(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: initctrl
                                                  .listSearchBrand.length,
                                              itemBuilder: (context, index) {
                                                return CardListSearch(
                                                    ontap: () {},
                                                    brand: initctrl
                                                            .listSearchBrand[
                                                        index]);
                                              }),
                                        )
                                      : const Center(
                                          child: Text(
                                            'not found !',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontFamily: 'cairo',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ))
                                  : Expanded(
                                      child: AlphabetScrollPage(
                                        brands: initctrl.brandList,
                                        className: "study_brand",
                                      ),
                                    );
                            }
                          })
                        ],
                      )
                    ]),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Visibility(
              visible:
                  MediaQuery.of(context).viewInsets.bottom != 0 ? false : true,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: BottomControllBar(0)),
            ),
          )
        ],
      ),
    );
  }
}
