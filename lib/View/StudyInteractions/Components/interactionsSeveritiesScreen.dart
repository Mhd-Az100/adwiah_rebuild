// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/StudyInteractions/Components/backgroundsDrawings.dart';
import 'package:adwiah/View/StudyInteractions/Components/interactionsComponents.dart';
import 'package:adwiah/View/StudyInteractions/ViewModel/interactions_view_model.dart';
import 'package:adwiah/Widgets/floatbox.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//wewew
class InteractionsSeveritiesScreen extends StatefulWidget {
  final details;
  final mode;
  InteractionsSeveritiesScreen(this.details, {this.mode = 0});
  @override
  _InteractionsSeveritiesScreenState createState() =>
      _InteractionsSeveritiesScreenState();
}

class _InteractionsSeveritiesScreenState
    extends State<InteractionsSeveritiesScreen> {
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
    controller.getInteractionsSeverities(widget.details[0]['ID']);
    var res = widget.mode == 0
        ? await controller.getInteractionsSeverities(widget.details[0]['ID'])
        : await controller.getInteractionsSeveritiesByBrand(
            widget.details[0]['Brand_ID'],
            widget.details[0]['Route'],
          );

    if (res != null) {
      setState(() {
        data = jsonDecode(res);
      });
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error!!!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Database is under update'),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok!!'),
              )
            ],
          );
        },
      );
    }
  }

  Widget loader() {
    if (data != null) {
      if (data.length == 0) {
        return Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffed5565))),
        );
      } else {
        for (var i = 0; i < data.length; i += 1) {
          subdata.add(Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SeveritiesCard(
                data[i],
                widget.details,
                mode: widget.mode,
              ),
              SizedBox(
                height: 15,
              )
            ],
          ));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            data[0]['topical_note'] != '' && data[0]['topical_note'] != null
                ? Text(
                    data[0]['topical_note'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green[600]),
                  )
                : SizedBox(),
            Column(
              children: subdata,
            ),
          ],
        );
      }
    } else {
      return Center(
          child: Text(
        'Erorr',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: Colors.black45,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1c2340),
        title: Align(
          alignment: Alignment.center,
          child: FittedBox(
            child: Text("INTERACTIONS SEVERITIES"),
          ),
        ),
        actions: <Widget>[BarcodeReader(mode: 1)],
      ),
      drawer: NavDrawer(),
      body: Stack(
        children: [
          CurvedBg1Reversed(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  widget.mode == 1
                      ? FloatTextBox(
                          this
                              .widget
                              .details[0]['Brand_Name']
                              .toString()
                              .toUpperCase(),
                          (widget.details[0]['Pharmaceutical_Form']))
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              this
                                  .widget
                                  .details[0]['Name']
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            )),
                          ),
                        ),
                  SizedBox(
                    height: 25,
                  ),
                  loader()
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
          child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: BottomControllBar(0))),
    );
  }
}
