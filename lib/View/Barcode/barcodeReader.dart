// ignore_for_file: prefer_final_fields, unused_field, unnecessary_null_comparison
import 'package:adwiah/View/Barcode/ViewModel/barcode_view_model.dart';
import 'package:adwiah/View/Barcode/brandsByBarcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class BarcodeReader extends StatelessWidget {
  final mode;
  BarcodeReader({Key? key, this.mode = 0}) : super(key: key);
  String _scanBarcode = 'Unknown';
  var controller = TextEditingController();
  BarcodeController ctrl = Get.put(BarcodeController());

  Future<String?> scanQr(context) async {
    try {
      final data = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(data);
      if (data != null && data != '-1') {
        ctrl.getbrandByBarc(data);
        Get.to(() => BrandByBarcode(data));
      }
      return data;
    } catch (error) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error!!!',
              style: TextStyle(color: Colors.red[900]),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Camera access denid'),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok!!'),
              )
            ],
          );
        },
      );
    }
    return null;
  }

  Future<void>? getInformation(code) {
    ctrl.getbrandByBarc(code);

    Get.to(() => BrandByBarcode(code));

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        icon: ImageIcon(
          const AssetImage('assets/icons/barc.png'),
          color: mode != 0 ? Colors.white : const Color(0xff1c2340),
          size: 100,
        ),
        onPressed: () async {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        height: 400,
                        width: 300,
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(child: Text('')),
                                    IconButton(
                                        icon: const Icon(Icons.close),
                                        color: Colors.black,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Scan By Camera',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 110,
                                            width: 110,
                                            child: IconButton(
                                              icon: const ImageIcon(
                                                AssetImage(
                                                    'assets/icons/barc.png'),
                                                color: Color.fromARGB(
                                                    255, 4, 4, 5),
                                                size: 100,
                                              ),
                                              onPressed: () async {
                                                await scanQr(context);
                                              },
                                            ),
                                          ),
                                          const Text(
                                            'Or Enter Barcode',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            controller: controller,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0)),
                                              labelText: 'Code',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: MaterialButton(
                                              color: Colors.grey,
                                              onPressed: () => getInformation(
                                                  controller.text),
                                              child: const Text('Submit'),
                                            ),
                                          )
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        iconSize: 40,
      ),
    );
  }
}
