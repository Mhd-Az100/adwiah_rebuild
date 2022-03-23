import 'package:adwiah/View/BarcodeScanner/barcodeReader.dart';
import 'package:adwiah/View/BrandsScreen/brands_view.dart';
import 'package:adwiah/View/DiseaseScreen/disease_drugs_view.dart';
import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/View/Home/Components/carsousel_slider_widget.dart';
import 'package:adwiah/View/Home/View_Model/home_view_model.dart';
import 'package:adwiah/View/IngredientsScreen/ingredient_view.dart';
import 'package:adwiah/View/StudyInteractionsScreen/study_iteractions_view.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    var imgList = [
      'assets/images/ingredients.png',
      'assets/images/trade_names.png',
      'assets/images/study_interactions.png',
      'assets/images/search_bydisease.png',
      'assets/images/find_ph.png',
      'assets/images/patient_profile.png',
    ];
    List<Widget> routingList = [
      IngredientsScreen(),
      BrandsScreen(),
      StudyInteractions(),
      DiseaseScreen(),
      // MapScreen(),
      IngredientsScreen(),
    ];

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to leave the App'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                    actions: [BarcodeReader(mode: 1)],
                  ),
                ),
                drawer: NavDrawer(),
                body: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25 -
                          45 -
                          MediaQuery.of(context).padding.top,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Carosel(imgList, routingList),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomControllBar(1))
          ],
        ),
      ),
    );
  }
}
