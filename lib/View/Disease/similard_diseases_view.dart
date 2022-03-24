// ignore_for_file: must_be_immutable

import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Disease/Components/dis_card.dart';
import 'package:adwiah/View/Disease/ViewModel/disease_view_model.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sized_context/sized_context.dart';

class SimilarDiseasesScreen extends StatelessWidget {
  SimilarDiseasesScreen({
    this.name,
    this.id,
    Key? key,
  }) : super(key: key);
  String? name;
  String? id;
  DiseaseController controller = Get.find<DiseaseController>();

  Widget build(BuildContext context) {
    controller.getdiseaseByI(id!);
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(
            height: 220,
            child: Header2(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: controller.lang.value == 'en'
                    ? FittedBox(
                        child: Text("Find Drugs By Disease",
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                            style: const TextStyle(fontSize: 24)))
                    : FittedBox(
                        child: Text("البحث عن دواء من خلال المرض",
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                            style: TextStyle(
                                fontSize:
                                    context.diagonalInches >= 7 ? 24 : 18))),
              ),
              actions: [BarcodeReader(mode: 1)],
            ),
            drawer: NavDrawer(),
            body: Column(
              children: [
                SizedBox(
                  height: 220 - MediaQuery.of(context).padding.top - 55,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18)),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Center(
                                child: Text(
                              name!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: Color(0xff1c2340),
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  controller.lang.value == "en"
                      ? 'SIMILAR DISEASES'
                      : 'امراض مشابهة',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(() => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: controller.loadbrandDisease.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xffed5565))),
                                )
                              : (controller.similarDisease.isEmpty
                                  ? Center(
                                      child: Text(
                                      controller.lang.value == "en"
                                          ? 'No Similar Diseases'
                                          : 'لا يوجد امراض مشابهة',
                                      style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.similarDisease.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DisCard(
                                            id: controller
                                                .similarDisease[index].keyId,
                                            name: controller.lang.value == 'en'
                                                ? controller
                                                    .similarDisease[index]
                                                    .diseaseName
                                                : controller
                                                    .similarDisease[index]
                                                    .diseaseNamesAr,
                                          ),
                                        );
                                      })),

                          //  Obx(() => loader()),
                        )),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
                color: const Color(0Xfff5eded),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 9),
                child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: BottomControllBar(0))),
          )
        ],
      ),
    );
  }
}
