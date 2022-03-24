import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Disease/Components/ing_card.dart';
import 'package:adwiah/View/Disease/ViewModel/disease_view_model.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseDetailScreen extends StatelessWidget {
  DiseaseDetailScreen(this.name, this.id);
  String name, id;
  DiseaseController controller = Get.find<DiseaseController>();

  @override
  Widget build(BuildContext context) {
    controller.getIngByDisease(id);
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
                child: Text(
                  "Find Drugs By Disease",
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              actions: <Widget>[BarcodeReader(mode: 1)],
            ),
            drawer: NavDrawer(),
            body: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 220 - MediaQuery.of(context).padding.top - 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(name,
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
                              name,
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
                      ),
                    ],
                  ),
                ),
                Text(
                  'Ingredients'.toUpperCase(),
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
                          child: controller.loadingByDisease.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xffed5565))),
                                )
                              : (controller.ingByDisease.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No Ings Found',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.ingByDisease.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IngCard(
                                              name: controller
                                                  .ingByDisease[index].name,
                                              id: controller
                                                  .ingByDisease[index].id
                                                  .toString()),
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
                    width: MediaQuery.of(context).size.width * 0.7,
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
