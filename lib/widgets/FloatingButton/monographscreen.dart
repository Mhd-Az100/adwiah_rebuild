// import 'dart:convert';
// import 'dart:developer';
// import 'package:adwiah/View/Barcode/barcodeReader.dart';
// import 'package:adwiah/View/Drawer/drawer_view.dart';
// import 'package:adwiah/Widgets/FloatingButton/TextReader.dart';
// import 'package:adwiah/Widgets/FloatingButton/custom_floatin_button_view.dart';
// import 'package:adwiah/Widgets/floatbox.dart';
// import 'package:adwiah/widgets/bottombar.dart';
// import 'package:adwiah/widgets/header.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// class MonographScreen extends StatefulWidget {
//   final id;
//   var name = '', pha = '', mode = 0;

//   MonographScreen(this.id, {this.name = '', this.pha = '', this.mode = 0});

//   @override
//   _MonographScreenState createState() => _MonographScreenState();
// }

// class _MonographScreenState extends State<MonographScreen>
//     with WidgetsBindingObserver {
//   var keys = [];
//   String lang = 'en';
//   Map<String, dynamic>? data;
//   List? dosage_Indicatio;
//   String? name;
//   bool isExpanded = false;
//   AudioPlayer player = AudioPlayer();
//   Map<String, bool> _playing = {};
//   GlobalKey<LangChangeFloatingButtonState> _myKey =
//       GlobalKey<LangChangeFloatingButtonState>();

//   String parseHtmlString(String htmlString) {
//     final document = parse(htmlString);
//     final String parsedString = parse(document.body.text).documentElement.text;

//     return parsedString;
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     player.stop();

//     data!.keys.forEach((element) {
//       _playing[element] = false;
//     });

//     super.didChangeAppLifecycleState(state);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     data!.keys.forEach((element) {
//       _playing[element] = false;
//     });
//     player.stop();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     WidgetsBinding.instance!.addObserver(this);
//     super.initState();
//     getData();
//   }

//   Widget speakButton(String field) {
//     return IconButton(
//         onPressed: () async {
//           var result;

//           print(_playing[field]);
//           player.stop();
//           if (_playing[field] != true) {
//             setState(() {
//               _playing.keys.forEach((element) {
//                 _playing[element.toString()] = false;
//               });
//             });
//             setState(() {
//               _playing[field] = true;
//             });
//             result = await player.speak(parseHtmlString(data![field]));
//             print(_playing[field]);
//             print(".............................................");
//             print(result);
//           } else {
//             player.stop();
//             setState(() {
//               _playing[field] = false;
//             });
//           }
//         },
//         icon:
//             _playing[field]! ? Icon(Icons.volume_up) : Icon(Icons.volume_off));
//   }

//   void getData() async {
//     try {
//       var token = await storage.read(key: 'token');
//       // var a = await getMonographByIngId(hostUrl1, widget.id, token);
//       // var trans = await getTranslatedMonographByIngId(hostUrl1,this.widget.id,'ar', token);
//       print(
//           '.............................................................................');
//       setState(() {
//         data = jsonDecode(a);
//         data!.keys.forEach((element) {
//           _playing[element] = false;
//         });
//         dosage_Indicatio = jsonDecode(data['Dosage_Indication_Keys']);
//         keys = jsonDecode(data['Keys']);
//         name = data!['NAME'];
//         log(data!['Keys']);
//       });
//     } on Exception catch (e) {
//       // TODO
//       showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(
//               'Error!!!',
//               style: TextStyle(color: Colors.red[900]),
//             ),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   Text(e.toString()),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               MaterialButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Ok!!'),
//               )
//             ],
//           );
//         },
//       );
//     }
//   }

//   Widget fabFade() {
//     if (isExpanded) {
//       return Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           color: Colors.black.withOpacity(0.8));
//     } else {
//       return SizedBox();
//     }
//   }

//   Widget monogrphField(String text) {
//     String rowText = parseHtmlString(text);
//     List<InlineSpan> finalTextSpans = [];
//     rowText.split('{{{').forEach((element) {
//       if (element.contains('}}}')) {
//         var text = keys
//             .where((x) =>
//                 x['Val_en'].toString().toLowerCase() ==
//                 element.split('}}}')[0].trimLeft().trimRight().toLowerCase())
//             .toList();
//         finalTextSpans.add(TextSpan(
//             text: element.split('}}}')[0],
//             style: TextStyle(
//                 decoration: TextDecoration.underline,
//                 color: Colors.cyan[700],
//                 fontWeight: FontWeight.w800,
//                 fontSize: 18),
//             recognizer: TapGestureRecognizer()
//               ..onTap = () {
//                 final controller = ScrollController();
//                 showDialog<void>(
//                   context: context,
//                   barrierDismissible: false, // user must tap button!
//                   builder: (BuildContext context) {
//                     return Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.white),
//                         width: MediaQuery.of(context).size.width * 0.7,
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             minHeight: 200,
//                             maxHeight: MediaQuery.of(context).size.height * 0.6,
//                           ),
//                           child: Material(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Expanded(child: Text('')),
//                                         IconButton(
//                                             icon: Icon(Icons.close),
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             }),
//                                       ],
//                                     ),
//                                     text.length > 0
//                                         ? Padding(
//                                             padding: const EdgeInsets.all(4.0),
//                                             child: (Column(
//                                               children: [
//                                                 Text(
//                                                   text[0]['Val_ar'] != null
//                                                       ? text[0]['Val_ar']
//                                                       : '',
//                                                   textAlign: TextAlign.right,
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       fontFamily: 'Cairo',
//                                                       fontWeight:
//                                                           FontWeight.w700),
//                                                 ),
//                                                 Text(
//                                                   text[0]['Explanation_ar'] !=
//                                                           null
//                                                       ? text[0]
//                                                           ['Explanation_ar']
//                                                       : '',
//                                                   textAlign: TextAlign.right,
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       fontFamily: 'Cairo'),
//                                                 ),
//                                                 Text(
//                                                     text[0]['Val_en'] != null
//                                                         ? text[0]['Val_en']
//                                                         : '',
//                                                     style: TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w700)),
//                                                 Text(
//                                                   text[0]['Explanation'] != null
//                                                       ? text[0]['Explanation']
//                                                       : '',
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                   ),
//                                                 )
//                                               ],
//                                             )),
//                                           )
//                                         : Text('Error No Such Key Available')
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }));
//         if (!element.endsWith('}}}')) {
//           finalTextSpans.add(TextSpan(
//               text: element.split('}}}')[1],
//               style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Roboto',
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500)));
//         }
//       } else {
//         finalTextSpans.add(TextSpan(
//             text: element,
//             style: TextStyle(
//                 color: Colors.black,
//                 fontFamily: 'Roboto',
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500)));
//       }
//     });
//     return RichText(
//       textScaleFactor: MediaQuery.of(context).textScaleFactor,
//       text: TextSpan(children: finalTextSpans, style: TextStyle(height: 1.5)),
//     );
//   }

//   List<InlineSpan> getDosageIndication() {
//     print(dosage_Indicatio);
//     List<InlineSpan> a = [];
//     var i = 0;
//     for (var d in dosage_Indicatio!) {
//       if (d['Val_en'] != null && d['Val_en'] != '') {
//         i += 1;
//         var ch = (i != dosage_Indicatio!.length ? ' , ' : '');
//         a.add(
//           TextSpan(
//               text: d['Val_en'] + ch,
//               style: TextStyle(
//                   height: 1.5,
//                   color: d['Explanation'] != null ||
//                           d['Explanation'] != '' ||
//                           d['Explanation_ar'] != null ||
//                           d['Explanation_ar'] != ''
//                       ? Colors.cyan[700]
//                       : Colors.black,
//                   decoration: d['Explanation'] != null ||
//                           d['Explanation'] != '' ||
//                           d['Explanation_ar'] != null ||
//                           d['Explanation_ar'] != ''
//                       ? TextDecoration.underline
//                       : TextDecoration.none,
//                   fontWeight: d['Explanation'] != null ||
//                           d['Explanation'] != '' ||
//                           d['Explanation_ar'] != null ||
//                           d['Explanation_ar'] != ''
//                       ? FontWeight.w800
//                       : FontWeight.w400,
//                   fontSize: 16),
//               recognizer: TapGestureRecognizer()
//                 ..onTap = () {
//                   final controller = ScrollController();
//                   if (d['Explanation'] != null ||
//                       d['Explanation'] != '' ||
//                       d['Explanation_ar'] != null ||
//                       d['Explanation_ar'] != '') {
//                     showDialog<void>(
//                       context: context,
//                       barrierDismissible: false, // user must tap button!
//                       builder: (BuildContext context) {
//                         return Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ConstrainedBox(
//                               constraints: BoxConstraints(
//                                 minHeight: 200,
//                                 maxHeight:
//                                     MediaQuery.of(context).size.height * 0.6,
//                               ),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     color: Colors.white),
//                                 width: MediaQuery.of(context).size.width * 0.8,
//                                 child: Material(
//                                   borderRadius: BorderRadius.circular(15),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: SingleChildScrollView(
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Expanded(child: Text('')),
//                                               IconButton(
//                                                   icon: Icon(Icons.close),
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   }),
//                                             ],
//                                           ),
//                                           Text(
//                                             d['Val_ar'] != null
//                                                 ? d['Val_ar']
//                                                 : '',
//                                             textAlign: TextAlign.right,
//                                             style: TextStyle(
//                                                 height: 1.5,
//                                                 fontFamily: 'Cairo',
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                           Text(
//                                             d['Explanation_ar'] != null
//                                                 ? d['Explanation_ar']
//                                                 : '',
//                                             textAlign: TextAlign.right,
//                                             style: TextStyle(
//                                               height: 1.5,
//                                               fontFamily: 'Cairo',
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                           Text(
//                                               d['Val_en'] != null
//                                                   ? d['Val_en']
//                                                   : '',
//                                               style: TextStyle(
//                                                   height: 1.5,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w700)),
//                                           Text(
//                                             d['Explanation'] != null
//                                                 ? d['Explanation']
//                                                 : '',
//                                             style: TextStyle(
//                                               height: 1.5,
//                                               fontSize: 16,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 }),
//         );
//       }
//     }
//     return a;
//   }

//   Widget loader() {
//     if (data != null) {
//       return ListView(
//         children: <Widget>[
//           SizedBox(
//             height: 20,
//           ),
//           FloatBox(
//               'MAIN INDICATIONS',
//               RichText(
//                 textScaleFactor: MediaQuery.of(context).textScaleFactor,
//                 textAlign: TextAlign.left,
//                 text: TextSpan(
//                     children: getDosageIndication(), style: TextStyle()),
//               )),
//           SizedBox(
//             height: 20,
//           ),
//           data!['Mechanism_of_action'] != '' &&
//                   data!['Mechanism_of_action'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                       'MECHANISM OF ACTION',
//                       Column(
//                         children: [
//                           monogrphField(
//                               parseHtmlString(data!['Mechanism_of_action'])),
//                           speakButton('Mechanism_of_action')
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data['Indications'] != '' && data!['Indications'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         'INDICATIONS',
//                         Column(
//                           children: [
//                             monogrphField(
//                                 parseHtmlString(data!['Indications'])),
//                             speakButton('Indications')
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data!['Contraindications'] != '' && data!['Contraindications'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         'CONTRAINDICATIONS',
//                         Column(
//                           children: [
//                             monogrphField(
//                                 parseHtmlString(data!['Contraindications'])),
//                             speakButton('Contraindications')
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data!['Precautions_and_warnings'] != '' &&
//                   data!['Precautions_and_warnings'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         'PRECAUTIONS AND WRNINGS',
//                         Column(
//                           children: [
//                             monogrphField(parseHtmlString(
//                                 data!['Precautions_and_warnings'])),
//                             speakButton('Precautions_and_warnings')
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data!['Pregnancy_and_lactation'] != '' &&
//                   data!['Pregnancy_and_lactation'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         'PREGNAMCY AND LACTATION',
//                         Column(
//                           children: [
//                             monogrphField(parseHtmlString(
//                                 data!['Pregnancy_and_lactation'])),
//                             speakButton('Pregnancy_and_lactation')
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           // FloatTextBox('NURSING IMPLICATIONS',
//           //     data! != null ? data!['Nursing_implications'] : 'loading...'),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           data!['Side_effects'] != '' && data!['Side_effects'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         'SIDE EFFECTS',
//                         Column(
//                           children: [
//                             monogrphField(
//                                 parseHtmlString(data!['Side_effects'])),
//                             speakButton('Side_effects')
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data!['Overdosage'] != '' && data!['Overdosage'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         'OVER DOSAGE',
//                         Column(
//                           children: [
//                             monogrphField(parseHtmlString(data!['Overdosage'])),
//                             speakButton('Overdosage')
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data!['Administration'] != '' && data!['Administration'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         'Administration',
//                         Column(
//                           children: [
//                             monogrphField(
//                                 parseHtmlString(data!['Administration'])),
//                             speakButton('Administration')
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data!['Patient_information'] != '' &&
//                   data!['Patient_information'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         'Patient information',
//                         Column(
//                           children: [
//                             monogrphField(
//                                 parseHtmlString(data!['Patient_information'])),
//                             speakButton('Patient_information')
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data!['Nursing_implications'] != '' &&
//                   data!['Nursing_implications'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         'Nursing implications',
//                         Column(
//                           children: [
//                             monogrphField(
//                                 parseHtmlString(data!['Nursing_implications'])),
//                             speakButton('Nursing_implications')
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),
//         ],
//       );
//     } else {
//       return Center(
//           child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Color(0xffed5565))));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0Xfff5eded),
//       body: Stack(
//         children: [
//           SizedBox(height: 220, child: Header2()),
//           Scaffold(
//             drawer: NavDrawer(),
//             backgroundColor: Colors.transparent,
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(50),
//               child: AppBar(
//                 elevation: 0,
//                 backgroundColor: Colors.transparent,
//                 title: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Monograph",
//                     textScaleFactor: MediaQuery.of(context).textScaleFactor,
//                     style: TextStyle(fontSize: 24),
//                   ),
//                 ),
//                 actions: [BarcodeReader(mode: 1)],
//               ),
//             ),
//             body: Column(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.7,
//                   height: 220 - MediaQuery.of(context).padding.top - 60,
//                   child: Center(
//                     child: this.widget.mode == 0
//                         ? FittedBox(
//                             child: InkWell(
//                               onTap: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         content: Text(
//                                             (data != null && name != null
//                                                 ? name!.toUpperCase()
//                                                 : '...'),
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 18)),
//                                         actions: [
//                                           MaterialButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text('Close'),
//                                           )
//                                         ],
//                                       );
//                                     });
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(15)),
//                                 width: 300,
//                                 height: 60,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Center(
//                                       child: Text(
//                                     (data != null && name != null
//                                         ? name!.toUpperCase()
//                                         : '...'),
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 18),
//                                   )),
//                                 ),
//                               ),
//                             ),
//                           )
//                         : FloatTextBox(this.widget.name, this.widget.pha),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                       padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
//                       child: loader()),
//                 ),
//               ],
//             ),
//             bottomNavigationBar: Container(
//                 color: Color(0Xfff5eded),
//                 padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
//                 child: Container(
//                     width: 200,
//                     height: 60,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: BottomControllBar(0))),
//           ),
//           fabFade(),
//           Positioned(
//             bottom: 13,
//             left: MediaQuery.of(context).size.width - 210,
//             child: Container(
//               width: 180,
//               child: LangChangeFloatingButton(
//                 key: _myKey,
//                 childrens: [
//                   SizedBox(
//                     height: 50,
//                     width: 50,
//                     child: FloatingActionButton(
//                         elevation: 0.0,
//                         highlightElevation: 0.0,
//                         hoverElevation: 0.0,
//                         focusElevation: 0.0,
//                         disabledElevation: 0.0,
//                         backgroundColor: Color(0xff5C376D),
//                         heroTag: "btn1",
//                         onPressed: () async {
//                           setState(() {
//                             data!.keys.forEach((element) {
//                               _playing[element] = false;
//                             });
//                             player.stop();
//                           });
//                           _myKey.currentState!.animate();
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => TranslatedMonograph(
//                                         this.widget.id,
//                                         'ar',
//                                         name: this.widget.mode == 0
//                                             ? name
//                                             : this.widget.name,
//                                         pha: this.widget.pha,
//                                         mode: this.widget.mode,
//                                       )));
//                         },
//                         child: Text(
//                           'AR',
//                           style: TextStyle(
//                             fontFamily: 'Roboto',
//                             fontSize: 16,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         )),
//                   ),
//                   // SizedBox(
//                   //   width: 56,
//                   //   height: 56,
//                   //   child: FloatingActionButton(
//                   //       backgroundColor: Color(0xff5C376D),
//                   //       heroTag: "btn2",
//                   //       onPressed: () async {
//                   //         Navigator.push(
//                   //             context,
//                   //             MaterialPageRoute(
//                   //                 builder: (context) => TranslatedMonograph(
//                   //                   this.widget.id,
//                   //                   'fr',
//                   //                   name:this.widget.mode == 0?name:this.widget.name,
//                   //                   pha: this.widget.pha,
//                   //                   mode: this.widget.mode,
//                   //                 )));
//                   //       },
//                   //       child: Text(
//                   //         'Fr',
//                   //         style: TextStyle(
//                   //           fontFamily: 'Roboto',
//                   //           fontSize: 16,
//                   //           color: Colors.white,
//                   //           fontWeight: FontWeight.w700,
//                   //         ),
//                   //       )),
//                   // ),
//                 ],
//                 onPressed: () {
//                   setState(() {
//                     isExpanded = !isExpanded;
//                   });
//                   print(isExpanded);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
