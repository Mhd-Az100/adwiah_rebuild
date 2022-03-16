import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_app_view_model.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //==========after create home controller I will put in========== //
    Get.find<InitialAppController>().geticons();
    // Get.find<InitialAppController>().getabouttexts();
    Get.find<InitialAppController>().getcountries();
    Get.find<InitialAppController>().getMedicianCenters();
    Get.find<InitialAppController>().getPosts();
    //============================================================ //
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Header(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                // actions: <Widget>[BarcodeReader(mode: 1)],
              ),
            ),
            drawer: NavDrawer(),
            body: Container(),
          ),
        ],
      ),
    );
  }
}
