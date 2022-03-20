import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/View/IngredientsScreen/Components/ingredients_topbar_widget.dart';
import 'package:adwiah/View/IngredientsScreen/ingred_details_view.dart';
import 'package:adwiah/View/IngredientsScreen/ingredient_view_model.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_app_view_model.dart';
import 'package:adwiah/Widgets/alphabet_scoll.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IngredientsScreen extends StatefulWidget {
  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  InitialAppController controller = Get.find<InitialAppController>();
  IngredientController ctrl = Get.put(IngredientController());

  @override
  void initState() {
    initData();
  }

  @override
  void initData() async {
    // var version = await storage.read(key: 'inglistversion');
    // print(version);
    // if (version != null) {
    //   var inglist = await storage.read(key: 'ingList');
    //   print(inglist);
    //   setState(() {
    //     data = jsonDecode(inglist);
    //     subdata = data;
    //   });
    // }
    // sortByName();
  }

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
                          IngredientsTopBar(
                              this.search, this.sortByAtc, this.sortByName),
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
                          Expanded(
                            child: AlphabetScrollPage(
                              ingredient: controller.ingredientList,
                              className: "ingreadient",
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: BottomControllBar(0)),
          )
        ],
      ),
    );
  }
}
