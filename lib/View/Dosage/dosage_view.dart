// import 'dart:ui';
// import 'package:adwiah/View/Barcode/barcodeReader.dart';
// import 'package:adwiah/View/Drawer/drawer_view.dart';
// import 'package:adwiah/Widgets/FloatingButton/dosage_detaild_box_view.dart';
// import 'package:adwiah/widgets/bottombar.dart';
// import 'package:adwiah/widgets/header.dart';
// import 'package:flutter/material.dart';

// class DosageScreen extends StatefulWidget {
//   final id;
//   var mode = 1, route, name, phaForm, dosageForm;
//   DosageScreen(this.id,
//       {this.route,
//       this.dosageForm,
//       this.name,
//       this.phaForm,
//       required this.mode});
//   @override
//   _DosageScreenState createState() => _DosageScreenState();
// }

// class _DosageScreenState extends State<DosageScreen> {
//   List details = [];
//   List list = [];
//   int i = 1;
//   final keys = {
//     'Type_en': '',
//     'Taken': 'Taken As :',
//     'Volume': 'Dosage Amount :',
//     'management_text': 'Management :',
//     'CombinedWith': 'Combined With :',
//     'administration_text': 'Adminstration :',
//     'Severity': 'Severity :',
//     'Disease': 'Disease :',
//     'Adjustment': 'Dose Adjustment :',
//     'DoseRelations_text': 'DoseRelations :',
//   };
//   @override
//   void initState() {
//     getDetails();

//     super.initState();
//   }

//   // List listToTree(list) {
//   // var map = new Map(), node = new Map(), roots = [], i;

//   // for (i = 0; i < list.length; i += 1) {
//   //   map[list[i]['id']] = i; // initialize the map
//   //   list[i]['children'] = new List(); // initialize the children
//   // }

//   // for (i = 0; i < list.length; i += 1) {
//   //   node = list[i];
//   //   print(node['id'].runtimeType);
//   //   if (node['parent_id'] != null) {
//   //     // if you have dangling branches check that map[node.parentId] exists
//   //     list[map[node['parent_id']]]['children'].add(node);
//   //   } else {
//   //     roots.add(node);
//   //   }
//   // }
//   // return roots;
//   // }

//   void getDetails() async {
//     // var token = await storage.read(key: 'token');
//     // var a;
//     // if (this.widget.mode == 1) {
//     //   a = await getDosageByBrandRoutDosageForm(hostUrl1, this.widget.id,
//     //       this.widget.route, this.widget.dosageForm, token);
//     // } else {
//     //   a = await getDosageByIngId(hostUrl1, this.widget.id, token);
//     // }
//     // if (a != null) {
//     //   setState(() {
//     //     details = jsonDecode(a);
//     //   });
//     // } else {
//     //   return showDialog<void>(
//     //     context: context,
//     //     barrierDismissible: false, // user must tap button!
//     //     builder: (BuildContext context) {
//     //       return AlertDialog(
//     //         title: Text('Error!!!'),
//     //         content: SingleChildScrollView(
//     //           child: ListBody(
//     //             children: <Widget>[
//     //               Text('Database is under update'),
//     //             ],
//     //           ),
//     //         ),
//     //         actions: <Widget>[
//     //           MaterialButton(
//     //             onPressed: () {
//     //               Navigator.of(context).pop();
//     //             },
//     //             child: Text('Ok!!'),
//     //           )
//     //         ],
//     //       );
//     //     },
//     //   );
//     // }
//     // setState(() {
//     //   print(listToTree(details));
//     //   list = listToTree(details);
//     //   log(list.toString());
//     // });
//   }

//   // Widget loader() {
//   //   if (details.length == 0) {
//   //     return Center(
//   //       child: CircularProgressIndicator(
//   //           valueColor: AlwaysStoppedAnimation<Color>(Color(0xff5C376D))),
//   //     );
//   //   } else {
//   //     // return TreeView(
//   //     //   parentList: dosageList(),
//   //     //   hasScrollBar: true,
//   //     // );
//   //     var controller = ScrollController();
//   //     return ListView.builder(
//   //       controller: controller,
//   //       shrinkWrap: true,
//   //       itemBuilder: (context, index) {
//   //         return printGroupTree(
//   //           list[index],
//   //           controller,
//   //         );
//   //       },
//   //       itemCount: list.length,
//   //     );
//   //   }
//   // }

//   // Widget printGroupTree(Map group, ScrollController controller,
//   //     {double level = 0, mode = 0, double index = 0}) {
//   //   var expanded = false;
//   //   if (group['children'].length != 0) {
//   //     // List<Widget> subGroups = List<Widget>();

//   //     for (var subGroup in group['children']) {
//   //       i += 1;
//   //       // subGroups.add(
//   //       //   printGroupTree(subGroup, controller,
//   //       //       level: subGroup['level'].toDouble(),
//   //       //       mode: mode,
//   //       //       index: index + i),
//   //       // );
//   //     }

//   //     var key = new GlobalKey();

//   //     return Container(
//   //       key: key,
//   //       child: Parent(
//   //         parent: _card(group['name'], level * 20, [], mode, expanded),
//   //         childList: ChildList(
//   //           children: subGroups,
//   //         ),
//   //         callback: (b) {
//   //           print(group['id']);
//   //           // if (!b) {
//   //           if (group['id'] == 1 || group['id'] == '1') {
//   //             controller.animateTo(
//   //                 controller.position.maxScrollExtent +
//   //                     group['children'].length * 60.0,
//   //                 duration: Duration(seconds: 2),
//   //                 curve: Curves.fastOutSlowIn);
//   //           } else
//   //             Scrollable.ensureVisible(
//   //               key.currentContext,
//   //               duration: Duration(seconds: 2),
//   //             );
//   //           // expanded=!expanded;

//   //           // }
//   //         },
//   //       ),
//   //     );
//   //   } else {
//   //     return _card(group['name'], level * 20,
//   //         jsonDecode(group['Dosage_Details']), mode, expanded);
//   //   }
//   // }

//   // Color setColor(level, mode) {
//   //   if (level == 0) {
//   //     return mode == 0 ? Color(0xff5C376D) : Colors.red[700];
//   //   }
//   //   if (level == 1) {
//   //     return mode == 0 ? Color(0xff5C376D).withOpacity(0.9) : Colors.red;
//   //   }
//   //   if (level == 2) {
//   //     return mode == 0 ? Color(0xff5C376D).withOpacity(0.8) : Colors.red[400];
//   //   }
//   //   if (level == 3) {
//   //     return mode == 0 ? Color(0xff5C376D).withOpacity(0.7) : Colors.red[200];
//   //   }
//   // }

//   // Color setTextColor(level) {
//   //   if (level == 0) {
//   //     return Colors.white;
//   //   }
//   //   if (level == 1) {
//   //     return Colors.white;
//   //   }
//   //   if (level == 2) {
//   //     return Colors.white;
//   //   }
//   //   if (level == 3) {
//   //     return Colors.white;
//   //   }
//   // }

//   Widget _card(
//       String groupName, double leftPadding, List data, parentMode, isExpanded) {
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Row(
//         children: <Widget>[
//           SizedBox(
//             width: leftPadding,
//           ),
//           Expanded(
//             child: data.length == 0
//                 ? Container(
//                     padding: EdgeInsets.only(
//                       left: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       // color: setColor(leftPadding / 20, parentMode),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     height: 50,
//                     child: Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: Container(
//                             height: 50,
//                             child: Center(
//                               child: Text(
//                                 groupName.replaceAll('<br>', '\n'),
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   // color: setTextColor(leftPadding / 20)
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         !data.isNotEmpty
//                             ? (!isExpanded
//                                 ? Icon(
//                                     Icons.expand_more,
//                                     size: 35,
//                                     color: Colors.white,
//                                   )
//                                 : Icon(
//                                     Icons.expand_less,
//                                     size: 35,
//                                     color: Colors.white,
//                                   ))
//                             : SizedBox(),
//                       ],
//                     ),
//                   )
//                 : InkWell(
//                     child: Container(
//                       padding: EdgeInsets.only(
//                         left: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         // color: setColor(leftPadding / 20, parentMode),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       height: 50,
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Container(
//                               height: 50,
//                               child: Center(
//                                 child: Text(
//                                   groupName.replaceAll('<br>', '\n'),
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     // color: setTextColor(leftPadding / 20)
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           !data.isNotEmpty
//                               ? Icon(
//                                   Icons.expand_more,
//                                   size: 35,
//                                   color: Colors.white,
//                                 )
//                               : SizedBox(),
//                         ],
//                       ),
//                     ),
//                     onTap: () {
//                       if (data.isNotEmpty) {
//                         List<Widget> text = [];
//                         for (var i = 0; i < data.length; i += 1) {
//                           text.add(RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               textAlign: TextAlign.center,
//                               text: TextSpan(children: [
//                                 (data[i]['Type_en'] != null
//                                     ? TextSpan(
//                                         text: data[i]['Type_en'],
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontFamily: 'Roboto',
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w800))
//                                     : TextSpan(text: '')),
//                                 (data[i]['CombinedWith'] != null
//                                     ? TextSpan(
//                                         text: '(CombinedWith : ' +
//                                             data[i]['CombinedWith'] +
//                                             ')',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontFamily: 'Roboto',
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w800))
//                                     : TextSpan(text: ''))
//                               ])));
//                           data[i]['Volume'] != '' && data[i]['Volume'] != null
//                               ? text.add(RichText(
//                                   textScaleFactor:
//                                       MediaQuery.of(context).textScaleFactor,
//                                   text: TextSpan(children: [
//                                     TextSpan(
//                                         text: 'Dosage Amount :',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontFamily: 'Roboto',
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w800)),
//                                     TextSpan(
//                                         text: data[i]['Volume'],
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontFamily: 'Roboto',
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w400))
//                                   ]),
//                                 ))
//                               : null;
//                           data[i]['Taken'] != '' && data[i]['Taken'] != null
//                               ? text.add(RichText(
//                                       textScaleFactor: MediaQuery.of(context)
//                                           .textScaleFactor,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                             text: 'Taken As : ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800)),
//                                         TextSpan(
//                                             text: data[i]['Taken'],
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400))
//                                       ]))
//                                   //'Taken As :' + data[i]['Taken']
//                                   )
//                               : null;
//                           data[i]['Duration_en'] != '' &&
//                                   data[i]['Duration_en'] != null
//                               ? text.add(RichText(
//                                       textScaleFactor: MediaQuery.of(context)
//                                           .textScaleFactor,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                             text: 'Duration : ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800)),
//                                         TextSpan(
//                                             text: data[i]['Duration_en'],
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400))
//                                       ]))
//                                   //'Duration :' + data[i]['Duration_en']
//                                   )
//                               : null;
//                           data[i]['administration_text'] != '' &&
//                                   data[i]['administration_text'] != null
//                               ? text.add(RichText(
//                                       textScaleFactor: MediaQuery.of(context)
//                                           .textScaleFactor,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                             text: 'Adminstration : ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800)),
//                                         TextSpan(
//                                             text: data[i]
//                                                 ['administration_text'],
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400))
//                                       ]))
//                                   // 'Administration :' +
//                                   //   data[i]['administration_text']
//                                   )
//                               : null;
//                           data[i]['DoseRelations_text'] != '' &&
//                                   data[i]['DoseRelations_text'] != null
//                               ? text.add(RichText(
//                                       textScaleFactor: MediaQuery.of(context)
//                                           .textScaleFactor,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                             text: 'Administration Note : ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800)),
//                                         TextSpan(
//                                             text: data[i]['DoseRelations_text'],
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400))
//                                       ]))
//                                   // 'Administration Note  :' +
//                                   //   data[i]['DoseRelations_text']
//                                   )
//                               : null;
//                           data[i]['management_text'] != '' &&
//                                   data[i]['management_text'] != null
//                               ? text.add(RichText(
//                                       text: TextSpan(children: [
//                                   TextSpan(
//                                       text: 'Management : ',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontFamily: 'Roboto',
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w800)),
//                                   TextSpan(
//                                       text: data[i]['management_text'],
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontFamily: 'Roboto',
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w400))
//                                 ]))
//                                   // 'Management  :' +
//                                   //   data[i]['management_text']
//                                   )
//                               : null;
//                           data[i]['Note_text'] != '' &&
//                                   data[i]['Note_text'] != null
//                               ? text.add(RichText(
//                                       textScaleFactor: MediaQuery.of(context)
//                                           .textScaleFactor,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                             text: 'Notes : ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800)),
//                                         TextSpan(
//                                             text: data[i]['Note_text'],
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400))
//                                       ]))
//                                   // 'Notes  :' + data[i]['Note_text']
//                                   )
//                               : null;
//                           data[i]['Disease'] != '' && data[i]['Disease'] != null
//                               ? text.add(RichText(
//                                       textScaleFactor: MediaQuery.of(context)
//                                           .textScaleFactor,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                             text: 'Disease : ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800)),
//                                         TextSpan(
//                                             text: data[i]['Disease'],
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400))
//                                       ]))
//                                   //'Disease  :' + data[i]['Disease']
//                                   )
//                               : null;
//                           data[i]['CreatinineClearanceRange'] != '' &&
//                                   data[i]['CreatinineClearanceRange'] != null
//                               ? text.add(RichText(
//                                       textScaleFactor: MediaQuery.of(context)
//                                           .textScaleFactor,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                             text: 'Creatinine Clearance : ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800)),
//                                         TextSpan(
//                                             text: data[i]
//                                                 ['CreatinineClearanceRange'],
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400))
//                                       ]))
//                                   // 'Creatinine Clearance  :' +
//                                   //   data[i]['CreatinineClearanceRange']
//                                   )
//                               : null;
//                           data[i]['Severity'] != '' &&
//                                   data[i]['Severity'] != null
//                               ? text.add(RichText(
//                                       textScaleFactor: MediaQuery.of(context)
//                                           .textScaleFactor,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                             text: 'Severity : ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800)),
//                                         TextSpan(
//                                             text: data[i]['Severity'],
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400))
//                                       ]))
//                                   //'Severity   : ' + data[i]['Severity']
//                                   )
//                               : null;
//                           data[i]['Adjustment'] != '' &&
//                                   data[i]['Adjustment'] != null
//                               ? text.add(RichText(
//                                       textScaleFactor: MediaQuery.of(context)
//                                           .textScaleFactor,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                             text: 'Dose Adjustment : ',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w800)),
//                                         TextSpan(
//                                             text: data[i]['Adjustment'],
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w400))
//                                       ]))
//                                   // 'Dose Adjustment   : ' +
//                                   //   data[i]['Adjustment']
//                                   )
//                               : null;
//                         }
//                         showDialog<void>(
//                           context: context,
//                           barrierDismissible: false, // user must tap button!
//                           builder: (BuildContext context) {
//                             return BackdropFilter(
//                               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                               child: Center(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       color: Colors.white),
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.8,
//                                   child: Material(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                   child: Text(
//                                                 groupName.replaceAll(
//                                                     '<br>', '\n'),
//                                               )),
//                                               IconButton(
//                                                   icon: Icon(Icons.close),
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   }),
//                                             ],
//                                           ),
//                                           DosageDetails(text),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       }
//                     }),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0Xfff5eded),
//       body: Stack(
//         children: [
//           SizedBox(height: 220, child: Header2()),
//           Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(50),
//               child: AppBar(
//                 elevation: 0,
//                 backgroundColor: Colors.transparent,
//                 title: Align(
//                   alignment: Alignment.center,
//                   child: FittedBox(
//                       child: Text(
//                     'Dosage',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//                     textScaleFactor: MediaQuery.of(context).textScaleFactor,
//                   )),
//                 ),
//                 actions: <Widget>[
//                   BarcodeReader(mode: 1),
//                 ],
//               ),
//             ),
//             drawer: NavDrawer(),
//             body: GestureDetector(
//               onTap: () {
//                 FocusScopeNode currentFocus = FocusScope.of(context);

//                 if (!currentFocus.hasPrimaryFocus) {
//                   currentFocus.unfocus();
//                 }
//               },
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 220 - MediaQuery.of(context).padding.top - 55,
//                       child: Center(
//                         child: FittedBox(
//                           child: InkWell(
//                             onTap: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       content: Text(this.widget.name,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 18)),
//                                       actions: [
//                                         MaterialButton(
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                           },
//                                           child: Text('Close'),
//                                         )
//                                       ],
//                                     );
//                                   });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(15)),
//                               width: MediaQuery.of(context).size.width * 0.7,
//                               height: 60,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Center(
//                                     child: Text(
//                                   this.widget.name.toUpperCase(),
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 16),
//                                 )),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: loader()),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             bottomNavigationBar: Container(
//                 color: Color(0Xfff5eded),
//                 padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
//                 child: Container(
//                     width: MediaQuery.of(context).size.width * 0.7,
//                     height: 60,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: BottomControllBar(0))),
//           ),
//         ],
//       ),
//     );
//   }
// }
