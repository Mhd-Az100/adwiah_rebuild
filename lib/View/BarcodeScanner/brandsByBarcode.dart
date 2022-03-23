// ignore_for_file: body_might_complete_normally_nullable, avoid_init_to_null, unnecessary_null_comparison, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:adwiah/View/BarcodeScanner/barcodeReader.dart';
import 'package:adwiah/View/BarcodeScanner/barcode_view_model.dart';
import 'package:adwiah/View/BrandsScreen/Components/brandCard.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandByBarcode extends StatelessWidget {
  final code;
  BrandByBarcode(this.code, {Key? key}) : super(key: key);
  BarcodeController controller = Get.find<BarcodeController>();
  @override
  Widget? loader() {
    if (controller.brandByBarcode != null) {
      if (controller.brandByBarcode.isEmpty) {
        return Center(
            child: SizedBox(
          height: 300,
          child: Center(
            child: Text(
              'Barcode for this trade name is\nnot available',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                color: Colors.red[900],
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
      } else {
        return Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: controller.brandByBarcode.length,
                itemBuilder: (context, int index) {
                  return BrandCard(controller.brandByBarcode[index]);
                }),
          ],
        );
      }
    } else if (controller.brandByBarcode == null) {
      return const Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffed5565))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(
            height: 220,
            child: Header2(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    child: Text("Trade Names",
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        style: const TextStyle(fontSize: 24))),
              ),
              actions: [BarcodeReader(mode: 1)],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          code.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() => controller.loadbrandByBarcode.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : loader()!),
                  ],
                ),
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
          )
        ],
      ),
    );
  }
}
