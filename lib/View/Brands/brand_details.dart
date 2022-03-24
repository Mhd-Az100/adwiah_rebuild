import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/View/Brands/Components/brand_icons.dart';
import 'package:adwiah/View/Brands/ViewModel/brands_view_model.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/Widgets/floatbox.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BrandDetailsScreen extends StatelessWidget {
  final BrandByIdModel details;
  BrandDetailsScreen(this.details, {Key? key}) : super(key: key);
  bool isExpanded = false;
  var id = 0;
  final oCcy = NumberFormat("#,##0", "en_US");
  final dateformat = DateFormat('dd/MM/yyyy');
  BrandsController ctrl = Get.find<BrandsController>();

  List<InlineSpan> getDosageIndication(context) {
    List<InlineSpan> a = [];
    var i = 0;
    for (var d in ctrl.indications) {
      i += 1;
      var ch = (i != ctrl.indications.length ? ' , ' : '');
      if (d.valEn != null && d.valEn != '') {
        a.add(
          TextSpan(
              text: d.valEn! + ch,
              style: TextStyle(
                  color: d.explanation != null ||
                          d.explanation != '' ||
                          d.explanationAr != null ||
                          d.explanationAr != ''
                      ? Colors.cyan[700]
                      : Colors.black,
                  fontWeight: d.explanation != null ||
                          d.explanation != '' ||
                          d.explanationAr != null ||
                          d.explanationAr != ''
                      ? FontWeight.w800
                      : FontWeight.w400,
                  fontSize: 18),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (d.explanation != null ||
                      d.explanation != '' ||
                      d.explanationAr != null ||
                      d.explanationAr != '') {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              // height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.all(8),
                              child: Material(
                                borderRadius: BorderRadius.circular(15),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 100,
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.7,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              d.valEn!,
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w800),
                                            )),
                                            IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        ),
                                        Text(
                                          d.valAr != null ? d.valAr! : '',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              height: 1.5,
                                              fontSize: 16,
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          d.explanationAr != null
                                              ? d.explanationAr!
                                              : '',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Cairo',
                                              height: 1.5),
                                        ),
                                        Text(d.valEn != null ? d.valEn! : '',
                                            style: const TextStyle(
                                                height: 1.5,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Text(
                                          d.explanation != null
                                              ? d.explanation!
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 16, height: 1.5),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
        );
      }
    }
    return a;
  }

  Widget loader(context) {
    if (details != null) {
      return Column(
        children: [
          SizedBox(
            height: 220 - MediaQuery.of(context).padding.top - 55,
            child: Center(
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                              details.brandName.toString().toUpperCase(),
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18)),
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
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      details.brandName.toString().toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    )),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: <Widget>[
                          FittedBox(
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Center(
                                        child: FittedBox(
                                          child: BranIconRow(details.bg,
                                              details.otc, details.icon),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(details != null
                                          ? details.pharmaceuticalForm!
                                          : 'Loading...'),
                                    ],
                                  )),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FloatBox(
                              'Main Indications',
                              RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                      children: ctrl.indications != null
                                          ? getDosageIndication(context)
                                          : []))),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Pha.Form : ' +
                                            (details != null
                                                ? details.pharmaceuticalForm
                                                    .toString()
                                                : 'Loading...'),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Composition : ' +
                                            (details != null
                                                ? details.compositionText!
                                                : 'Loading...'),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Route : ' +
                                            (details != null
                                                ? details.route!
                                                : 'Loading...'),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Families : ' +
                                            (details != null
                                                ? details.families!
                                                : 'Loading...'),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Price : ' +
                                            (details != null
                                                ? details.price!
                                                : 'Loading...') +
                                            "  ",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Last Price Update : ' +
                                            (details != null &&
                                                    details.lastUpdateDate !=
                                                        null
                                                ? dateformat.format(
                                                    dateformat.parse(details
                                                        .lastUpdateDate!))
                                                : 'Loading...'),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Color(0xffed5565),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Lab/Country : ' +
                                            (details != null
                                                ? details.lab!
                                                : 'Loading...'),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  details.lic != null
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'License Provider : ' +
                                                  (details != null
                                                      ? details.lic
                                                      : 'Loading...'),
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
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
              centerTitle: true,
              title: Text("Trade Names",
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  style: const TextStyle(fontSize: 24)),
              // actions: <Widget>[BarcodeReader(mode: 1)],
            ),
            drawer: NavDrawer(),
            body: loader(context),
            bottomNavigationBar: Visibility(
              visible:
                  MediaQuery.of(context).viewInsets.bottom != 0 ? false : true,
              child: Container(
                  color: const Color(0Xfff5eded),
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 9),
                  child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: BottomControllBar(0))),
            ),
          ),

          // Positioned(
          //   bottom: 13,
          //   left: MediaQuery.of(context).size.width -
          //       (MediaQuery.of(context).size.width * 0.4 + 40),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width * 0.4,
          //     child: CustomFloatingButton(
          //       details: this.details,
          //       mode: 1,
          //       id: id,
          //       onPressed: () {
          //         setState(() {
          //           isExpanded = !isExpanded;
          //         });
          //         print(isExpanded);
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
