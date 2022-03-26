import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Brands/Components/brandCard.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/Widgets/FloatingButton/ViewModel/floating_button_view_model_view.dart';
import 'package:adwiah/Widgets/floatbox.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlternativeBrandsScreen extends StatelessWidget {
  BrandByIdModel details;
  AlternativeBrandsScreen(this.details, {Key? key}) : super(key: key);
  FloatingButtonController controller = Get.find<FloatingButtonController>();

  @override
  Widget build(BuildContext context) {
    controller.getAlternitve(
        id: details.ingId.toString(),
        route: details.route,
        compositionID: details.compositionId.toString(),
        authorizationID: details.authorizationId.toString());
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(
            child: Header2(),
            height: 220,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    child: Text("Equal Trade Names",
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        style: const TextStyle(fontSize: 24))),
              ),
              actions: [BarcodeReader(mode: 1)],
            ),
            drawer: NavDrawer(),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: FloatTextBox(
                        details.brandName.toString().toUpperCase(),
                        (details.pharmaceuticalForm!)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff1c2340),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: const Center(
                      child: Text(
                        'CAN BE REPLACED BY',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GetBuilder<FloatingButtonController>(
                      initState: (_) {},
                      builder: (c) {
                        return c.loadAlternitve.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xffed5565))),
                              )
                            : (c.alternitve.isEmpty
                                ? SizedBox(
                                    height: 300,
                                    child: Center(
                                        child: Text(
                                      'NO EQUALS TRADE NAMES AVAILABLE IN THE SELECTED COUNTRY',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        color: Colors.red[900],
                                        height: 1.6,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: c.alternitve.length,
                                      itemBuilder: (context, int index) =>
                                          BrandCard(c.alternitve[index]),
                                    ),
                                  ));
                      }),
                ],
              ),
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
