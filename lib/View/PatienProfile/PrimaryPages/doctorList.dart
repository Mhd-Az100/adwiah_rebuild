// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/PatienProfile/addDoctor.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/header.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorsList extends StatefulWidget {
  final String lang;
  DoctorsList({this.lang = "en"});
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  List<DoctorModel> doctors = <DoctorModel>[];

  void initData() async {
    var data = await DatabaseHelper.instance!.getDoctors() ?? [];
    setState(() {
      doctors = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      drawer: NavDrawer(),
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header2()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    child: Text(widget.lang == "en"
                        ? 'My Doctor\'s List'
                        : 'قائمة اطبائي')),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(children: <Widget>[
                  SizedBox(
                      height: 220 - MediaQuery.of(context).padding.top - 55),
                  Expanded(
                      child: ListView.builder(
                          itemCount: doctors.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 8,
                                  child: ListTile(
                                    minLeadingWidth: 50,
                                    leading: Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(500),
                                          color: Color(0xff5C376D),
                                        ),
                                        child:
                                            Image.asset('assets/img/25.png')),
                                    title: Text(
                                      doctors[i].name.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          doctors[i].specialization!,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          doctors[i].phone!,
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            color: Color(0xff5C376D),
                                          ),
                                          child: IconButton(
                                              onPressed: () {
                                                showDialog<void>(
                                                  context: context,
                                                  barrierDismissible:
                                                      false, // user must tap button!
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        'Call The Doctor',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            ListTile(
                                                              title: Text(
                                                                doctors[i]
                                                                    .phone
                                                                    .toString(),
                                                              ),
                                                              onTap: () async {
                                                                if (await canLaunch(
                                                                    'tel:' +
                                                                        doctors[i]
                                                                            .phone!)) {
                                                                  launch('tel://' +
                                                                      doctors[i]
                                                                          .phone!);
                                                                }
                                                              },
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                doctors[i]
                                                                    .mobile
                                                                    .toString(),
                                                              ),
                                                              onTap: () async {
                                                                if (await canLaunch(
                                                                    'tel:' +
                                                                        doctors[i]
                                                                            .mobile!)) {
                                                                  launch('tel://' +
                                                                      doctors[i]
                                                                          .mobile!);
                                                                }
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        MaterialButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Ok!!'),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.phone,
                                                color: Colors.white,
                                              )),
                                        ),
                                        // SizedBox(height: 5,),
                                        // Expanded(
                                        //   child: IconButton(
                                        //       onPressed: () {},
                                        //       color:Color(0xff5C376D),
                                        //       icon: Container(
                                        //         child: Icon(
                                        //           Icons.phone,
                                        //           color: Colors.white,
                                        //         ),
                                        //
                                        //       )),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          }))
                ]),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Color(0xff5C376D),
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddDoctor()))
                    .then((value) {
                  setState(() {
                    initData();
                  });
                });
              },
            ),
          ),
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
