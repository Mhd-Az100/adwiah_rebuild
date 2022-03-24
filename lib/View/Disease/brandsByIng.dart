import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Brands/Components/brandCard.dart';
import 'package:adwiah/View/Disease/ViewModel/disease_view_model.dart';
import 'package:adwiah/View/Drawer/Profile/edit_profile_view.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsByIngScreen extends StatelessWidget {
  final id, name;
  BrandsByIngScreen(this.id, this.name, {Key? key}) : super(key: key);
  DiseaseController controller = Get.find<DiseaseController>();

  @override
  Widget build(BuildContext context) {
    controller.getBrandByIng(id);
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header2()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                      child: Text(
                    "Trade Names",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  )),
                ),
                actions: [BarcodeReader(mode: 1)],
              ),
            ),
            drawer: NavDrawer(),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
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
                                        content: Text(
                                            name.toString().toUpperCase(),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    name.toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(() => controller.loadbrandByIng.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xffed5565))),
                            )
                          : (controller.brandByIng.isEmpty
                              ? SizedBox(
                                  height: 300,
                                  child: Center(
                                      child: Text(
                                    'No Trade Names Found For This Ingredient In The Selected Country',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      height: 1.6,
                                      fontSize: 16,
                                      color: Colors.red[900]!,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.brandByIng.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: BrandCard(
                                              controller.brandByIng[index]),
                                        );
                                      }),
                                )))
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
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
        ],
      ),
    );
  }
}
