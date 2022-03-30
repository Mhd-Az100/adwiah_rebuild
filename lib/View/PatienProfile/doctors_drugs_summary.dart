// import 'package:adwiah/components/barcodeReader.dart';
// import 'package:adwiah/components/bottombar.dart';
// import 'package:adwiah/components/header.dart';
// import 'package:adwiah/db_helper.dart';
// import 'package:adwiah/screens/AdwiahDrawer.dart';
// import 'package:flutter/material.dart';
// import '../utils.dart';


// class DoctorDrugsSummary extends StatefulWidget {
//   final lang;
//   int presentId;
//   String drugsName;
//   DoctorDrugsSummary({Key key,this.lang,this.presentId,this.drugsName}) : super(key: key);

//   @override
//   _DoctorDrugsSummaryState createState() => _DoctorDrugsSummaryState();
// }

// class _DoctorDrugsSummaryState extends State<DoctorDrugsSummary> {
//   var lang;
//   int presentId ;
//   String drugsName ;

//   List<DrugsModel> _drugsList = [];


//   void _getData() async{
//     setState(() {
//       presentId = widget.presentId;
//       drugsName = widget.drugsName;
//     });
//      var _data = await DatabaseHelper.instance.getDrugsByPrescriptionIdAndDrugsName(presentId,drugsName)??[];
//     setState(() {
//       _drugsList = _data;
//       print("drugs list : $_drugsList");
//     });

//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     lang = widget.lang;
//     _getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: NavDrawer(),
//       body: Stack(
//         children: [
//           SizedBox(height: 220, child: Header()),
//           Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               actions: <Widget>[BarcodeReader(mode: 1)],
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               title: Align(
//                 alignment: Alignment.center,
//                 child: FittedBox(
//                     child: Text(widget.lang == "en"
//                         ? "Drugs Summary"
//                         : "ملخص الأدوية")),
//               ),
//             ),
//             body: GestureDetector(
//               onTap: () {
//                 FocusScopeNode currentFocus = FocusScope.of(context);
//                 if (!currentFocus.hasPrimaryFocus) {
//                   currentFocus.unfocus();
//                 }
//               },
//               child:Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 220 - MediaQuery.of(context).padding.top - 50,
//                       ),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Row(children: <Widget>[
//                                 Expanded(
//                                     child: Divider(
//                                       thickness: 1,
//                                       color: Colors.black,
//                                     )),
//                                 Text(
//                                     lang == "en"
//                                         ? " Drugs Info "
//                                         : "معلومات الدواء",
//                                     style: TextStyle(
//                                         color: Color(0xff5C376D),
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold)),
//                                 Expanded(
//                                     child: Divider(
//                                       thickness: 1,
//                                       color: Colors.black,
//                                     )),
//                               ]),
//                               SizedBox(height: 10),
//                               ListView.builder(
//                                   physics: NeverScrollableScrollPhysics(),
//                                   primary: true,
//                                   shrinkWrap: true,
//                                   itemCount:_drugsList.length ,
//                                   itemBuilder: (context,index){
//                                     return drugsCard(_drugsList[index]);
//                               })
//                             ],
//                           ),
//                         ),
//                       ),
//                     ]),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(

//           padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
//           child: Container(
//               width: 200,
//               height: 60,
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(10)),
//               child: BottomControllBar(0))),
//     );
//   }

//   Widget drugsCard(DrugsModel drugsModel){
//     return InkWell(
//       // onTap: btnClick,
//       child: Stack(
//         alignment: AlignmentDirectional.centerEnd,
//         children: [
//           Card(
//             elevation: 5.0,

//             margin: EdgeInsets.only(top: 10, bottom: 10, right: 20),
//             shadowColor: Utils.primaryColor,
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Utils.primaryColor)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 130,
//                         padding: EdgeInsets.only(
//                             top: 2, bottom: 2, right: 10, left: 10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.grey.shade50),
//                         child: Text(
//                           lang == "en" ? "Drugs Name" : "اسم الدواء",
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           drugsModel.name,
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),

//                   Row(
//                     children: [
//                       Container(
//                         width: 130,
//                         padding: EdgeInsets.only(
//                             top: 2, bottom: 2, right: 10, left: 10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.grey.shade50),
//                         child: Text(
//                           lang == "en" ? 'Take Type' : "طريقة أخذ الدواء",
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           drugsModel.take,
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         width: 130,
//                         padding: EdgeInsets.only(
//                             top: 2, bottom: 2, right: 10, left: 10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.grey.shade50),
//                         child: Text(
//                           lang == "en" ? 'Date' : "التاريح",
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           drugsModel.date,
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         width: 130,
//                         padding: EdgeInsets.only(
//                             top: 2, bottom: 2, right: 10, left: 10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.grey.shade50),
//                         child: Text(
//                           lang == "en" ? 'Time' : 'الوقت',
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           drugsModel.time,
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black),
//                         ),
//                       )
//                     ],
//                   ),SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         width: 130,
//                         padding: EdgeInsets.only(
//                             top: 2, bottom: 2, right: 10, left: 10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.grey.shade50),
//                         child: Text(
//                           lang == "en" ? 'Duration' : 'التكرار',
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text(
//                           drugsModel.duration,
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // SizedBox(
//           //   height: 40,
//           //   width: 40,
//           //   child: Material(
//           //     elevation: 6,
//           //     borderRadius: BorderRadius.circular(50),
//           //     color: const Color(0xff5C376D),
//           //     child: IconButton(
//           //       icon: Icon(
//           //         Icons.arrow_forward,
//           //         color: Colors.white,
//           //       ),
//           //       onPressed: btnClick,
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

// }
