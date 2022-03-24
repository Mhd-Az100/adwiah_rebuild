import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Disease/ViewModel/disease_view_model.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:adwiah/Widgets/AlphaScroll/alphabet_scoll_view.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/Widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseScreen extends StatelessWidget {
  DiseaseScreen({Key? key}) : super(key: key);
  InitialAppController controller = Get.find<InitialAppController>();
  DiseaseController ctrl = Get.put(DiseaseController());
  final searchController = TextEditingController();

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
                    title: Text("Find Drugs By Disease",
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        style: const TextStyle(fontSize: 24)),
                    actions: [BarcodeReader(mode: 1)],
                  ),
                  drawer: NavDrawer(),
                  body: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Stack(children: [
                      Column(
                        children: [
                          SearchBar(
                            searchController: searchController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialButton(
                                  minWidth: 130,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        color: ctrl.lang.value == 'en'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  height: 45,
                                  onPressed: () {
                                    ctrl.lang.value = 'en';
                                  },
                                  color: ctrl.lang.value == 'en'
                                      ? const Color(0xff5C376D)
                                      : Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  minWidth: 130,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'العربية',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14,
                                        color: ctrl.lang.value == 'ar'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  height: 45,
                                  onPressed: () {
                                    ctrl.lang.value = 'ar';
                                  },
                                  color: ctrl.lang.value == 'ar'
                                      ? const Color(0xff5C376D)
                                      : Colors.white,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Expanded(
                            child: AlphabetScrollPage(
                              disease: controller.diseaselist,
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
