import 'package:adwiah/View/InitialPages/View_Model/initial_data_view_model.dart';
import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sized_context/sized_context.dart';

class AdwiahIcons extends StatelessWidget {
  InitialAppController controller = Get.find<InitialAppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(
            height: 220,
            child: Header(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: FittedBox(
                  child: Text("Adiwah Icons",
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      style: TextStyle(
                          fontSize: context.diagonalInches >= 7 ? 24 : 18))),
              // actions: <Widget>[BarcodeReader(mode: 1)],
            ),
            drawer: NavDrawer(),
            body: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 220 - MediaQuery.of(context).padding.top - 55,
                  child: Center(
                    child: FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MaterialButton(
                                minWidth: 130,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: const FittedBox(
                                  child: Text(
                                    'English',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                      // color: lang == 'en'
                                      // ? Colors.white
                                      // : Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                height: 45,
                                onPressed: () {
                                  // setState(() {
                                  //   lang = 'en';
                                  // });
                                },
                                // color: lang == 'en'
                                //     ? Color(0xff5C376D)
                                //     : Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MaterialButton(
                                minWidth: 130,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: const FittedBox(
                                  child: Text(
                                    'العربية',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      // color: lang == 'ar'
                                      //     ? Colors.white
                                      //     : Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                height: 45,
                                onPressed: () {
                                  // setState(() {
                                  //   lang = 'ar';
                                  // });
                                },
                                // color: lang == 'ar'
                                //     ? Color(0xff5C376D)
                                //     : Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: controller.iconsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.fromBorderSide(BorderSide(
                              color: Colors.black54.withOpacity(0.1),
                              width: 1.0)),
                        ),
                        child: ListTile(
                          leading: Image.network(
                            controller.iconsList[index].iconUrl!
                                .toString()
                                .trim(),
                          ),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                    controller.iconsList[index].iconNameEn!),
                              ),
                              Expanded(
                                child: Text(
                                  controller.iconsList[index].iconNameAr!,
                                  style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ))
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
