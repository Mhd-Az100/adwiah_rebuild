import 'package:adwiah/View/DrawerPages/Components/card_medician_widget.dart';
import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_app_view_model.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalWebsites extends StatelessWidget {
  InitialAppController controller = Get.put(Get.find<InitialAppController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Header()),
          Scaffold(
            drawer: NavDrawer(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              // actions: <Widget>[BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    child: Text('Health Care Mediacl Websites',
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        style: const TextStyle(fontSize: 24))),
              ),
            ),
            body: Column(children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25 -
                      MediaQuery.of(context).padding.top -
                      55),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: controller.medicalCentersList.length,
                  itemBuilder: ((context, index) {
                    return CardMedicianWidget(
                        controller: controller, index: index);
                  }),
                ),
              ))
            ]),
            bottomNavigationBar: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: BottomControllBar(0))),
          ),
        ],
      ),
    );
  }
}
