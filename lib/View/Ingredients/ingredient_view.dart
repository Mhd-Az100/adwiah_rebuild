import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/Ingredients/Components/ingredients_topbar_widget.dart';
import 'package:adwiah/View/Ingredients/ingred_details_view.dart';
import 'package:adwiah/View/Ingredients/ViewModel/ingredient_view_model.dart';
import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:adwiah/Widgets/AlphaScroll/alphabet_scoll_view.dart';
import 'package:adwiah/Widgets/AlphaScroll/ViewModel/alphabet_view_model.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/card_list_search_widget.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IngredientsScreen extends StatefulWidget {
  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  InitialAppController controller = Get.find<InitialAppController>();
  IngredientController ctrl = Get.put(IngredientController());
  AlphaBetController ctrlalpha = Get.find<AlphaBetController>();

  @override
  void initState() {
    super.initState();
    controller.onsearch.value = false;
    ctrlalpha.studyIngorTrand.value = true;

    Get.find<AlphaBetController>().sortbyname.value = true;
  }

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
                    title: Text("Ingredients",
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
                          IngredientsTopBar(),
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
                          const SizedBox(
                            height: 8,
                          ),
                          Obx(() {
                            return controller.onsearch.value
                                ? (controller.listSearchIng.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                controller.listSearchIng.length,
                                            itemBuilder: (context, index) {
                                              return CardListSearch(
                                                  ontap: () {
                                                    Get.to(IngDetailsScreen(
                                                        controller
                                                            .listSearchIng[
                                                                index]
                                                            .id
                                                            .toString(),
                                                        controller
                                                            .listSearchIng[
                                                                index]
                                                            .name!));
                                                  },
                                                  ingredient: controller
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
                                      ingredient: controller.ingredientList,
                                      className: "ingreadient",
                                    ),
                                  );
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
