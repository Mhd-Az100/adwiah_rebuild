import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_data_view_model.dart';
import 'package:adwiah/Widgets/AlphaScroll/alphabet_scoll_view.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/Widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseScreen extends StatelessWidget {
  DiseaseScreen({Key? key}) : super(key: key);
  InitialAppController controller = Get.find<InitialAppController>();
  final searchController = TextEditingController();

  void search(String v) {}

  void sortByName() {}

  void sortByAtc() {}

  @override
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
                    title: Text("[Find Drugs By Disease]",
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
                          SearchBar(
                            searchController: searchController,
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Expanded(
                            child: AlphabetScrollPage(
                              brands: controller.brandList,
                              className: "disease",
                            ),
                          )
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
