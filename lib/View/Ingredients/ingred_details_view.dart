import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/Ingredients/ViewModel/ingredient_view_model.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/floatbox.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IngDetailsScreen extends StatelessWidget {
  final String id;
  final String name;
  IngDetailsScreen(this.id, this.name, {Key? key}) : super(key: key);
  IngredientController controller = Get.find<IngredientController>();

  @override
  Widget build(BuildContext context) {
    controller.getingMonos(id);
    controller.getTherapeutic(id);
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header2()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text("Ingredients",
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    style: const TextStyle(fontSize: 24)),
                // actions: <Widget>[BarcodeReader(mode: 1)],
              ),
            ),
            drawer: NavDrawer(),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 220 - MediaQuery.of(context).padding.top - 55,
                    child: Center(
                      child: FittedBox(
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
                                borderRadius: BorderRadius.circular(15)),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                  child: Text(
                                name.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Obx(() => FloatBox(
                                'Therapeutic Categories',
                                controller.loadther.value
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.ingTherapeutic.length,
                                        itemBuilder: (context, int index) {
                                          return RichText(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${controller.ingTherapeutic[index].motherAtc} ',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${controller.ingTherapeutic[index].motherName} \n',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${controller.ingTherapeutic[index].atc} ',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${controller.ingTherapeutic[index].name} \n',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                              style:
                                                  const TextStyle(height: 1.5),
                                            ),
                                          );
                                        })
                                    : Text(
                                        'loading...',
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                              )),

                          // FloatTextBox(
                          //     'SYNONYMS AND INGREDIENTS',
                          //     details != null
                          //         ? (synonyms != '' ? synonyms : '-NONE-')
                          //         : 'loading...'),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() => FloatBox(
                              'Synonyms And Ingredients',
                              controller.loadsynon.value
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.ingMonos.length,
                                      itemBuilder: (context, int index) {
                                        return RichText(
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    '(${controller.ingMonos[index].atc}) ',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${controller.ingMonos[index].name} \n',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              controller.ingMonos[index]
                                                              .ingSynonyms !=
                                                          null &&
                                                      controller.ingMonos[index]
                                                              .ingSynonyms !=
                                                          ''
                                                  ? TextSpan(
                                                      text:
                                                          '${controller.ingMonos[index].ingSynonyms} \n',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Roboto',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  : TextSpan()
                                            ],
                                            style: const TextStyle(height: 1.5),
                                          ),
                                        );
                                      })
                                  : Text(
                                      'loading...',
                                      textScaleFactor: MediaQuery.of(context)
                                          .textScaleFactor,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Roboto',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ))),
                          // FloatBox(
                          //     'THERAPEUTIC CATEGORIES',
                          //     catDetails != null
                          //         ? RichText(
                          //             text: TextSpan(
                          //                 children: th,
                          //                 style: TextStyle(height: 1.5)))
                          //         : Text(
                          //             'loading...',
                          //             style: TextStyle(
                          //                 color: Colors.black,
                          //                 fontFamily: 'Roboto',
                          //                 fontSize: 15,
                          //                 fontWeight: FontWeight.w500),
                          //           )),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
            bottomNavigationBar: Visibility(
              visible:
                  MediaQuery.of(context).viewInsets.bottom != 0 ? false : true,
              child: Container(
                  color: const Color(0Xfff5eded),
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 9),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: BottomControllBar(0))),
            ),
          ),
          // fabFade(),
          // Positioned(
          //   bottom: 13,
          //   left: MediaQuery.of(context).size.width -
          //       (MediaQuery.of(context).size.width * 0.4 + 40),
          // child: Container(
          //   width: MediaQuery.of(context).size.width * 0.4,
          //   child: CustomFloatingButton(
          //     id: this.widget.id,
          //     name: this.widget.name,
          //     onPressed: () {
          //       setState(() {
          //         isExpanded = !isExpanded;
          //       });
          //       print(isExpanded);
          //     },
          //     mode: 0,
          //   ),
          // ),
          // ),
        ],
      ),
    );
  }
}
