// import 'dart:convert';
// import 'dart:ui';
// import 'package:adwiah/Widgets/FloatingButton/TextReader.dart';
// import 'package:adwiah/Widgets/floatbox.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// class TranslatedMonograph extends StatefulWidget {
//   final id;
//   final lang;
//   var name = '', pha = '', mode = 0;
//   TranslatedMonograph(this.id, this.lang,
//       {this.name = '', this.pha = '', this.mode = 0});
//   @override
//   _TranslatedMonographState createState() => _TranslatedMonographState();
// }

// class _TranslatedMonographState extends State<TranslatedMonograph>
//     with WidgetsBindingObserver {
//   var keys = [];
//   String lang = 'en';
//   var data;
//   List? dosage_Indicatio;
//   String? name;
//   AudioPlayer player = AudioPlayer();
//   Map<String, bool> _playing = {};

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     setState(() {
//       data.keys.forEach((element) {
//         _playing[element] = false;
//       });
//       player.stop();
//     });
//     super.didChangeAppLifecycleState(state);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     setState(() {
//       data.keys.forEach((element) {
//         _playing[element] = false;
//       });
//       player.stop();
//     });
//     super.dispose();
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
//             result = await player.speak(parseHtmlString(data[field]));
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
//         icon: _playing[field] ? Icon(Icons.volume_up) : Icon(Icons.volume_off));
//   }

//   void getData() async {
//     try {
//       var token = await storage.read(key: 'token');
//       var a = await getTranslatedMonographByIngId(
//           hostUrl1, this.widget.id, this.widget.lang, token);
//       var k = await getMonographKeysByIngId(hostUrl1, this.widget.id, token);
//       // var trans = await getTranslatedMonographByIngId(hostUrl1,this.widget.id,'ar', token);
//       print(
//           '.............................................................................');
//       setState(() {
//         data = jsonDecode(a);
//         data.keys.forEach((element) {
//           _playing[element] = false;
//         });
//         keys = jsonDecode(k);
//       });
//       showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: AlertDialog(
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: <Widget>[
//                     Column(
//                       children: [
//                         Center(
//                           child: RichText(
//                             textScaleFactor:
//                                 MediaQuery.of(context).textScaleFactor,
//                             textAlign: TextAlign.center,
//                             text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                       text: 'ملاحظة \n',
//                                       style: TextStyle(
//                                           fontFamily: 'Cairo',
//                                           fontWeight: FontWeight.w800)),
//                                   TextSpan(
//                                       text:
//                                           'هذه الترجمة الية و غير دقيقة نعتذر عن وجود اخطاء و كذلك قراءة النص ليست بصوت بشري و انما هي الية كذلك'),
//                                 ],
//                                 style: TextStyle(
//                                     fontFamily: 'Cairo',
//                                     fontSize: 18,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         MaterialButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           color: Color(0xfff5C376D),
//                           disabledColor: Color(0xfff5C376D),
//                           disabledElevation: 3,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100.0),
//                               side: BorderSide(color: Color(0xff5C376D))),
//                           child: Text(
//                             'OK',
//                             style: TextStyle(
//                               fontFamily: 'Roboto',
//                               fontSize: 22,
//                               color: const Color(0xffffffff),
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           height: 45,
//                           minWidth: MediaQuery.of(context).size.width,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     } on Exception catch (e) {
//       showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: AlertDialog(
//               title: Text(
//                 'لقد حدث خطأ!!!',
//                 style: TextStyle(color: Colors.red[900]),
//                 textDirection: TextDirection.rtl,
//               ),
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: <Widget>[
//                     Text("""
//       عذراً..... 
// خدمة الترجمة الآلية متوقفة حالياً
// يرجى المحاولة لاحقاً
//       """,
//                         textScaleFactor: MediaQuery.of(context).textScaleFactor,
//                         textDirection: TextDirection.rtl,
//                         style: TextStyle(
//                             fontFamily: 'Cairo',
//                             fontSize: 18,
//                             color: Colors.black)),
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 MaterialButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Ok!!'),
//                 )
//               ],
//             ),
//           );
//         },
//       );
//     }
//   }

//   List<InlineSpan> monogrphField(String rowText) {
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
//                 fontFamily: 'Cairo',
//                 color: Colors.cyan[700],
//                 fontWeight: FontWeight.w800,
//                 fontSize: 17),
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
//                         height: 300,
//                         width: 300,
//                         child: Material(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(child: Text('')),
//                                     IconButton(
//                                         icon: Icon(Icons.close),
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         }),
//                                   ],
//                                 ),
//                                 Expanded(
//                                   child: Scrollbar(
//                                     radius: Radius.circular(10),
//                                     controller: controller,
//                                     isAlwaysShown: true,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: ListView(
//                                         controller: controller,
//                                         children: text.length > 0
//                                             ? [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(4.0),
//                                                   child: (Column(
//                                                     children: [
//                                                       Text(
//                                                         text[0]['Val_ar'] !=
//                                                                 null
//                                                             ? text[0]['Val_ar']
//                                                             : '',
//                                                         textAlign:
//                                                             TextAlign.right,
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w700),
//                                                       ),
//                                                       Text(
//                                                         text[0]['Explanation_ar'] !=
//                                                                 null
//                                                             ? text[0][
//                                                                 'Explanation_ar']
//                                                             : '',
//                                                         textAlign:
//                                                             TextAlign.right,
//                                                       ),
//                                                       Text(
//                                                           text[0]['Val_en'] !=
//                                                                   null
//                                                               ? text[0]
//                                                                   ['Val_en']
//                                                               : '',
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700)),
//                                                       Text(text[0][
//                                                                   'Explanation'] !=
//                                                               null
//                                                           ? text[0]
//                                                               ['Explanation']
//                                                           : '')
//                                                     ],
//                                                   )),
//                                                 )
//                                               ]
//                                             : [
//                                                 Text(
//                                                     'Error No Such Key Available')
//                                               ],
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
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
//                   fontFamily: 'Cairo',
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700)));
//         }
//       } else {
//         finalTextSpans.add(TextSpan(
//             text: element,
//             style: TextStyle(
//                 color: Colors.black,
//                 fontFamily: 'Cairo',
//                 fontSize: 17,
//                 fontWeight: FontWeight.w700)));
//       }
//     });
//     return finalTextSpans;
//   }

//   Widget loader() {
//     if (data != null) {
//       return ListView(
//         children: <Widget>[
//           SizedBox(
//             height: 20,
//           ),

//           data['Indications'] != '' && data['Indications'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar' ? 'دواعي الإستعمال' : 'INDICATIONS',
//                         Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: Column(
//                             children: [
//                               RichText(
//                                 textScaleFactor:
//                                     MediaQuery.of(context).textScaleFactor,
//                                 text: TextSpan(
//                                     children: monogrphField(
//                                         parseHtmlString(data['Indications']))),
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               getKeys('Indications').length != 0
//                                   ? Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Directionality(
//                                         textDirection: TextDirection.rtl,
//                                         child: RichText(
//                                             text: TextSpan(
//                                                 children:
//                                                     getKeys('Indications'))),
//                                       ),
//                                     )
//                                   : SizedBox(),
//                             ],
//                           ),
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data['Mechanism_of_action'] != '' &&
//                   data['Mechanism_of_action'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar'
//                             ? 'آلية العمل'
//                             : 'MECHANISM OF ACTION',
//                         Column(
//                           children: [
//                             RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               text: TextSpan(
//                                 children: monogrphField(parseHtmlString(
//                                     data['Mechanism_of_action'])),
//                               ),
//                             ),
//                             speakButton('Mechanism_of_action'),
//                             getKeys('Mechanism_of_action').length != 0
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: Directionality(
//                                         textDirection: TextDirection.rtl,
//                                         child: RichText(
//                                             textAlign: TextAlign.left,
//                                             text: TextSpan(
//                                                 children: getKeys(
//                                                     'Mechanism_of_action'))),
//                                       )),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data['Contraindications'] != '' && data['Contraindications'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar'
//                             ? 'مضادات الاستطباب'
//                             : 'CONTRAINDICATIONS',
//                         Column(
//                           children: [
//                             RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               text: TextSpan(
//                                   children: monogrphField(parseHtmlString(
//                                       data['Contraindications']))),
//                             ),
//                             speakButton('Contraindications'),
//                             getKeys('Contraindications').length != 0
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: RichText(
//                                               text: TextSpan(
//                                                   children: getKeys(
//                                                       'Contraindications')))),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data['Precautions_and_warnings'] != '' &&
//                   data['Precautions_and_warnings'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar'
//                             ? 'الاحتياطات والتحذيرات'
//                             : 'PRECAUTIONS AND WRNINGS',
//                         Column(
//                           children: [
//                             RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               text: TextSpan(
//                                   children: monogrphField(parseHtmlString(
//                                       data['Precautions_and_warnings']))),
//                             ),
//                             speakButton('Precautions_and_warnings'),
//                             getKeys('Precautions_and_warnings').length != 0
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: RichText(
//                                               text: TextSpan(
//                                                   children: getKeys(
//                                                       'Precautions_and_warnings')))),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data['Pregnancy_and_lactation'] != '' &&
//                   data['Pregnancy_and_lactation'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar'
//                             ? 'الحمل والرضاعة'
//                             : 'PREGNAMCY AND LACTATION',
//                         Column(
//                           children: [
//                             RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               text: TextSpan(
//                                   children: monogrphField(parseHtmlString(
//                                       data['Pregnancy_and_lactation']))),
//                             ),
//                             speakButton('Pregnancy_and_lactation'),
//                             getKeys('Pregnancy_and_lactation').length != 0
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: RichText(
//                                               text: TextSpan(
//                                                   children: getKeys(
//                                                       'Pregnancy_and_lactation')))),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           // FloatTextBox('NURSING IMPLICATIONS',
//           //     data != null ? data['Nursing_implications'] : 'loading...'),
//           // SizedBox(
//           //   height: 20,
//           // ),
//           data['Side_effects'] != '' && data['Side_effects'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar'
//                             ? 'الآثار الجانبية'
//                             : 'SIDE EFFECTS',
//                         Column(
//                           children: [
//                             RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               text: TextSpan(
//                                   children: monogrphField(
//                                       parseHtmlString(data['Side_effects']))),
//                             ),
//                             speakButton('Side_effects'),
//                             getKeys('Side_effects').length != 0
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: RichText(
//                                               text: TextSpan(
//                                                   children: getKeys(
//                                                       'Side_effects')))),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data['Overdosage'] != '' && data['Overdosage'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar' ? 'الجرعة الزائدة' : 'OVER DOSAGE',
//                         Column(
//                           children: [
//                             RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               text: TextSpan(
//                                   children: monogrphField(
//                                       parseHtmlString(data['Overdosage']))),
//                             ),
//                             speakButton('Overdosage'),
//                             getKeys('Overdosage').length != 0
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: RichText(
//                                               text: TextSpan(
//                                                   children:
//                                                       getKeys('Overdosage')))),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data['Administration'] != '' && data['Administration'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar' ? 'الادارة' : 'Administration',
//                         Column(
//                           children: [
//                             RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               text: TextSpan(
//                                   children: monogrphField(
//                                       parseHtmlString(data['Administration']))),
//                             ),
//                             speakButton('Administration'),
//                             getKeys('Administration').length != 0
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: RichText(
//                                               text: TextSpan(
//                                                   children: getKeys(
//                                                       'Administration')))),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data['Patient_information'] != '' &&
//                   data['Patient_information'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar'
//                             ? 'معلومات المريض'
//                             : 'Patient information',
//                         Column(
//                           children: [
//                             RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               text: TextSpan(
//                                   children: monogrphField(parseHtmlString(
//                                       data['Patient_information']))),
//                             ),
//                             speakButton('Patient_information'),
//                             getKeys('Patient_information').length != 0
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: RichText(
//                                               text: TextSpan(
//                                                   children: getKeys(
//                                                       'Patient_information')))),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                           ],
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 )
//               : Container(),

//           data['Nursing_implications'] != '' &&
//                   data['Nursing_implications'] != null
//               ? Column(
//                   children: [
//                     FloatBox(
//                         widget.lang == 'ar'
//                             ? 'آثار التمريض'
//                             : 'Nursing implications',
//                         Column(
//                           children: [
//                             RichText(
//                               textScaleFactor:
//                                   MediaQuery.of(context).textScaleFactor,
//                               text: TextSpan(
//                                   children: monogrphField(parseHtmlString(
//                                       data['Nursing_implications']))),
//                             ),
//                             speakButton('Nursing_implications'),
//                             getKeys('Nursing_implications').length != 0
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Center(
//                                           child: RichText(
//                                               text: TextSpan(
//                                                   children: getKeys(
//                                                       'Nursing_implications')))),
//                                     ),
//                                   )
//                                 : SizedBox(),
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

//   List<InlineSpan> getKeys(String type) {
//     List<InlineSpan> a = [];
//     var i = 0;
//     for (var d in keys) {
//       i += 1;
//       if (d['Val_en'] != null && d['Val_en'] != '' && d['TermType'] == type) {
//         var ch = (i != keys.length ? ' , ' : '');
//         a.add(
//           TextSpan(
//               text: widget.lang == 'ar' && d['Val_ar'] != null
//                   ? d['Val_ar'].toString() + ch
//                   : d['Val_en'].toString() + ch,
//               style: TextStyle(
//                   fontFamily: 'Cairo',
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
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: Colors.white),
//                             height: 300,
//                             width: 300,
//                             child: Material(
//                               borderRadius: BorderRadius.circular(15),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
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
//                                     Expanded(
//                                       child: Scrollbar(
//                                         radius: Radius.circular(10),
//                                         controller: controller,
//                                         isAlwaysShown: true,
//                                         child: ListView(
//                                           controller: controller,
//                                           children: [
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(4.0),
//                                               child: Column(
//                                                 children: [
//                                                   Text(
//                                                     d['Val_ar'] != null
//                                                         ? d['Val_ar']
//                                                         : '',
//                                                     textAlign: TextAlign.right,
//                                                     style: TextStyle(
//                                                         fontSize: 16,
//                                                         fontFamily: 'Cairo',
//                                                         fontWeight:
//                                                             FontWeight.w700),
//                                                   ),
//                                                   Text(
//                                                     d['Explanation_ar'] != null
//                                                         ? d['Explanation_ar']
//                                                         : '',
//                                                     textAlign: TextAlign.right,
//                                                     style: TextStyle(
//                                                         fontSize: 16,
//                                                         fontFamily: 'Cairo'),
//                                                   ),
//                                                   Text(
//                                                       d['Val_en'] != null
//                                                           ? d['Val_en']
//                                                           : '',
//                                                       style: TextStyle(
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.w700)),
//                                                   Text(
//                                                     d['Explanation'] != null
//                                                         ? d['Explanation']
//                                                         : '',
//                                                     style: TextStyle(
//                                                       fontSize: 16,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
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

//   @override
//   void initState() {
//     // TODO: implement initState
//     WidgetsBinding.instance.addObserver(this);
//     getData();
//     super.initState();
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
//                   child: Text("Monograph", style: TextStyle(fontSize: 24)),
//                 ),
//                 actions: <Widget>[BarcodeReader(mode: 1)],
//               ),
//             ),
//             body: Column(
//               children: [
//                 SizedBox(
//                   width: 300,
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
//                                         content: Text(this.widget.name,
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
//                                     (data != null && widget.name != null
//                                         ? widget.name.toUpperCase()
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
//                       child: widget.lang == 'ar'
//                           ? Directionality(
//                               textDirection: TextDirection.rtl, child: loader())
//                           : loader()),
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
//         ],
//       ),
//     );
//   }
// }
