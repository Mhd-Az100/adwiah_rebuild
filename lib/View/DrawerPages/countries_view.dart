import 'package:adwiah/View/DrawerPages/Components/card_countries_widget.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_data_view_model.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Countries extends StatelessWidget {
  Countries({Key? key}) : super(key: key);
  InitialAppController controller = Get.find<InitialAppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(height: 180, child: Header()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: const Text(
                  "Select Country",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300,
                  height: 180 - MediaQuery.of(context).padding.top - 60,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'soon... \n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Cairo',
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                  text: 'other countries will be available')
                            ],
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w600))),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: 'قريبا... \n',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Cairo',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(text: 'دول اخرى ستكون متاحة')
                            ],
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w600))),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.countriesList.length,
                      itemBuilder: (context, index) {
                        return CarCountries(
                            controller: controller, index: index);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
