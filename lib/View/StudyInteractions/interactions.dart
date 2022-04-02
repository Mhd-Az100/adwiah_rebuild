// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, unnecessary_null_comparison, prefer_is_empty

import 'dart:convert';
import 'dart:ui';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Dosage/dosage_detaild_box_view.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/StudyInteractions/ViewModel/interactions_view_model.dart';
import 'package:adwiah/Widgets/floatbox.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class GetInteractions extends StatefulWidget {
  final details, id, mode;
  const GetInteractions({this.details, this.id, this.mode});
  @override
  _GetInteractionsState createState() => _GetInteractionsState();
}

class _GetInteractionsState extends State<GetInteractions> {
  var data = [];
  List<Widget> subdata = [];
  StudyInteractionsController controller =
      Get.find<StudyInteractionsController>();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    print(widget.id);
    var res = widget.mode == 0
        ? await controller.getInteractions(
            widget.id,
          )
        : await controller.getInteractions(widget.id);

    if (res != null) {
      setState(() {
        data = jsonDecode(res);
      });
      data[0]['Severity_Level_ID'] == 4
          ? showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AlertDialog(
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Column(
                            children: [
                              Center(
                                child: RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      children: const [
                                        TextSpan(
                                            text:
                                                'في ما يلي قائمة بالتعارضات شديدة الخطورة ' +
                                                    "\n \n"),
                                        TextSpan(
                                            text: 'ملاحظة \n',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800)),
                                        TextSpan(
                                            text:
                                                ' يوجد بعض التعارضات بدرجة خطورة أقل يمكنك إيجادها فقط عبر موقع الانترنت الخاص بنا'),
                                        TextSpan(text: '\nwww.adwiah.net\n\n'),

                                        TextSpan(
                                            text:
                                                'Here are a list of contraindicated interactions ' +
                                                    "\n \n"),
                                        TextSpan(
                                            text: 'Note \n',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800)),
                                        TextSpan(
                                            text:
                                                ' there are less serious interactions; you can find them in our website.'),
                                        TextSpan(text: '\nwww.adwiah.net '),
                                        // TextSpan(
                                        //     text: ' www.adwiah.net ',
                                        //     style: TextStyle(
                                        //         fontStyle: FontStyle.italic,
                                        //         color: Colors.black54),
                                        //   recognizer: TapGestureRecognizer()
                                        //     ..onTap=()async{
                                        //       print('Launching.................');
                                        //     if (await canLaunch('https://adwiah.net/')) {
                                        //
                                        //       await launch(
                                        //         'https://adwiah.net/',
                                        //         forceSafariVC: true,
                                        //         forceWebView: true,
                                        //       );
                                        //       return;
                                        //     }
                                        //   }
                                        // )
                                      ],
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Color(0xfff5C376D),
                                disabledColor: Color(0xfff5C376D),
                                disabledElevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                    side: BorderSide(color: Color(0xff5C376D))),
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 22,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                height: 45,
                                minWidth: MediaQuery.of(context).size.width,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AlertDialog(
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Column(
                            children: [
                              RichText(
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    children: const [
                                      TextSpan(
                                          text:
                                              'لا يوجد تعارضات شديدة الخطورة لهذا الدواء ' +
                                                  "\n \n"),
                                      TextSpan(
                                          text: 'ملاحظة \n',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800)),
                                      TextSpan(
                                          text:
                                              'في ما يلي بعض التعارضات الهامة، كما يمكنك إيجاد بعض التعارضات بدرجة خطورة أقل فقط عبر موقع الانترنت الخاص بنا'),
                                      TextSpan(text: '\nwww.adwiah.net\n\n'),
                                      TextSpan(
                                          text:
                                              'There are no contraindicated interactions for this drug ' +
                                                  "\n \n"),
                                      TextSpan(
                                          text: 'Note \n',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800)),
                                      TextSpan(
                                          text:
                                              'Here are a list of most serious interactions, although there are less significant ones you can find them only in our website.'),
                                      TextSpan(text: '\nwww.adwiah.net'),
                                    ],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Color(0xfff5C376D),
                                disabledColor: Color(0xfff5C376D),
                                disabledElevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                    side: BorderSide(color: Color(0xff5C376D))),
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 22,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                height: 45,
                                minWidth: MediaQuery.of(context).size.width,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
    } else {
      setState(() {
        data = [];
      });

      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Column(
                      children: [
                        RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              children: const [
                                TextSpan(
                                    text:
                                        'لا يوجد تعارضات شديدة الخطورة لهذا الدواء ' +
                                            "\n \n"),
                                TextSpan(
                                    text: 'ملاحظة \n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                                TextSpan(
                                    text:
                                        'يوجد بعض التعارضات بدرجة خطورة أقل يمكنك إيجادها فقط عبر موقع الانترنت الخاص بنا'),
                                TextSpan(text: '\nwww.adwiah.net\n\n'),
                                TextSpan(
                                    text:
                                        'There are no contraindicated interactions for this drug ' +
                                            "\n \n"),
                                TextSpan(
                                    text: 'Note \n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                                TextSpan(
                                    text:
                                        'there are less significant ones you can find them only in our website.'),
                                TextSpan(text: '\nwww.adwiah.net'),
                              ],
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Color(0xfff5C376D),
                          disabledColor: Color(0xfff5C376D),
                          disabledElevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              side: BorderSide(color: Color(0xff5C376D))),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 22,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          height: 45,
                          minWidth: MediaQuery.of(context).size.width,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Widget loader() {
    if (data != null) {
      if (data.length == 0) {
        return Center(
          child: Text('No Contraindicated  Interaction'),
        );
      } else {
        for (var i = 0; i < data.length; i += 1) {
          subdata.add(SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: InkWell(
                onTap: () async {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Loading'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const [
                              Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xffed5565))),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  var a = await controller.getInteractionDetails(
                      data[i]['Interaction_ID'].toString());
                  var res = jsonDecode(a);
                  List<Widget> text = [];
                  text.add(RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        (res[0]['IngA_name'] != null
                            ? TextSpan(
                                children: [
                                    TextSpan(
                                        text: res[0]['IngA_name'],
                                        style: TextStyle(
                                            height: 1.5,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800)),
                                    TextSpan(
                                        text: ' interact with ',
                                        style: TextStyle(
                                            height: 1.5,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    TextSpan(
                                        text: res[0]['IngB_name'],
                                        style: TextStyle(
                                            height: 1.5,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800)),
                                    TextSpan(
                                        text: ' as the following : ',
                                        style: TextStyle(
                                            height: 1.5,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))
                                  ],
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                            : TextSpan(text: '')),
                      ])));

                  text.add(RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        (res[0]['Severity_Level'] != null
                            ? TextSpan(children: [
                                TextSpan(
                                    text: 'Severity Level : ',
                                    style: TextStyle(
                                        height: 1.5,
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800)),
                                TextSpan(
                                    text: res[0]['Severity_Level'],
                                    style: TextStyle(
                                        height: 1.5,
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400))
                              ])
                            : TextSpan(text: '')),
                      ])));
                  text.add(RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        (res[0]['InterActionType'] != null
                            ? TextSpan(children: [
                                TextSpan(
                                    text: 'InterAction Type  : ',
                                    style: TextStyle(
                                        height: 1.5,
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800)),
                                TextSpan(
                                    text: res[0]['InterActionType'],
                                    style: TextStyle(
                                        height: 1.5,
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400))
                              ])
                            : TextSpan(text: '')),
                      ])));
                  Navigator.pop(context);
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          // height: MediaQuery.of(context).size.height*0.7,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                        'Interactions details',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ))),
                                      IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  ),
                                  DosageDetails(text),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.fromBorderSide(
                        BorderSide(color: Colors.black54, width: 2.0)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Html(
                        data: data[i]['IngB_Name'],
                      )),
                ),
              ),
            ),
          ));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: subdata,
        );
      }
    } else {
      return SizedBox(
        height: 300,
        child: Center(
            child: Text(
          'No Contraindicated Interactions',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            color: Colors.red[900],
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header2()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    child: Text("Interactions",
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        style: TextStyle(fontSize: 24))),
              ),
              actions: <Widget>[BarcodeReader(mode: 1)],
            ),
            drawer: NavDrawer(),
            body: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 220 - MediaQuery.of(context).padding.top - 60,
                  child: Center(
                    child: widget.mode == 1
                        ? FloatTextBox(
                            widget.details[0]['Brand_Name']
                                .toString()
                                .toUpperCase(),
                            (widget.details[0]['Pharmaceutical_Form']))
                        : Center(
                            child: FittedBox(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(
                                              widget.details[0]['Name']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18)),
                                          actions: [
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Close'),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      widget.details[0]['Name']
                                          .toString()
                                          .toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [loader()],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
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
