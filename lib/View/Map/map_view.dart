// import 'dart:collection';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   bool isReady = false;
//   LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
//   GoogleMapController? _controller;
//   Location _location = Location();
//   Map<String, Marker> _markers = {};

//   Set<Circle> _circle = HashSet<Circle>();
//   var zoom = 2;

//   @override
//   void initState() {
//     initData();
//     super.initState();
//   }

//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   void initData() async {
//     // var phversion = await storage.read(key: 'phlistversion');
//     // print(phversion);
//     // var token = await storage.read(key: 'token');
//     // var versions = await getListsVersion(hostUrl1, token);

//     LocationData l = await _location.getLocation();
//     setState(() {
//       _circle.add(Circle(
//           circleId: CircleId('1'),
//           center: LatLng(l.latitude!, l.longitude!),
//           radius: zoom.toDouble() * 1000,
//           fillColor: Colors.blue.withOpacity(0.4),
//           strokeColor: Colors.blue,
//           strokeWidth: 3));

//       _initialcameraposition = LatLng(l.latitude!, l.longitude!);
//     });
//     List data;

//     //   if (versions != null) {
//     //     if (versions[3]['version'] != phversion) {
//     //       try {
//     //         var a = await getPhLocations(hostUrl1, token);
//     //         await storage.write(key: 'phlist', value: a);
//     //         data = jsonDecode(a);
//     //         await storage.write(
//     //             key: 'phlistversion', value: versions[3]['version']);
//     //       } on Exception catch (e) {
//     //         print(e);
//     //       }
//     //     } else {
//     //       try {
//     //         var a = await storage.read(key: 'phlist');
//     //         print(a);
//     //         data = jsonDecode(a);
//     //       } on Exception catch (e) {
//     //         print("erorrrrrrrrrrrrrrrrr");
//     //         print(e);
//     //       }
//     //     }
//     //   }
//     //   final Map<String, Marker> temp = {};
//     //   data.forEach((element) {
//     //     if (element['lat'] != null &&
//     //         element['lat'] != '' &&
//     //         element['lon'] != null &&
//     //         element['lon'] != '') {
//     //       if (calculateDistance(l.latitude, l.longitude,
//     //               double.parse(element['lat']), double.parse(element['lon'])) <=
//     //           zoom) {
//     //         temp[element['phnamear']] = Marker(
//     //           markerId: MarkerId(element['phnamear']),
//     //           position: LatLng(double.parse(element['lat'].toString()),
//     //               double.parse(element['lon'].toString())),
//     //           infoWindow: InfoWindow(
//     //             title: element['phnamear'],
//     //             snippet: element['loc1'].toString() +
//     //                 ' / ' +
//     //                 element['loc2'].toString() +
//     //                 ' / ' +
//     //                 element['loc3'].toString() +
//     //                 ' / ' +
//     //                 element['tel'],
//     //           ),
//     //         );
//     //       }
//     //     }
//     //   });

//     //   setState(() {
//     //     isReady = true;
//     //     _markers = temp;
//     //   });
//   }

//   void _onMapCreated(GoogleMapController _cntlr) async {
//     _controller = _cntlr;
//     _location.onLocationChanged.listen((l) {
//       _controller?.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
//         ),
//       );
//     });
//     // LocationData l = await _location.getLocation();
//     // _cntlr.moveCamera(
//     //   CameraUpdate.newCameraPosition(
//     //     CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
//     //   ),
//     // );
//     // setState(() {
//     //
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Stack(
//             children: [
//               GoogleMap(
//                 initialCameraPosition:
//                     CameraPosition(target: _initialcameraposition),
//                 mapType: MapType.normal,
//                 onMapCreated: _onMapCreated,
//                 myLocationEnabled: true,
//                 markers: _markers.values.toSet(),
//                 circles: _circle,
//               ),
//               Positioned(
//                   left: MediaQuery.of(context).size.width - 50,
//                   top: MediaQuery.of(context).size.width - 120,
//                   child: Container(
//                     height: 140,
//                     width: 50,
//                     color: Colors.white,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             height: 30,
//                             width: 30,
//                             child: Material(
//                               borderRadius: BorderRadius.circular(100),
//                               color:
//                                   zoom == 2 ? Color(0xffed5565) : Colors.grey,
//                               child: MaterialButton(
//                                   padding: new EdgeInsets.all(3.0),
//                                   child: Text('2k'),
//                                   onPressed: () {
//                                     setState(() {
//                                       zoom = 2;
//                                       _circle.clear();

//                                       _circle.add(Circle(
//                                           circleId: CircleId('1'),
//                                           center: _initialcameraposition,
//                                           radius: zoom.toDouble() * 1000,
//                                           fillColor:
//                                               Colors.blue.withOpacity(0.4),
//                                           strokeColor: Colors.blue,
//                                           strokeWidth: 3));
//                                     });
//                                     initData();
//                                   }),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             height: 30,
//                             width: 30,
//                             child: Material(
//                               borderRadius: BorderRadius.circular(100),
//                               color:
//                                   zoom == 3 ? Color(0xffed5565) : Colors.grey,
//                               child: MaterialButton(
//                                   padding: new EdgeInsets.all(3.0),
//                                   child: Text('3k'),
//                                   onPressed: () {
//                                     setState(() {
//                                       zoom = 3;
//                                       _circle.clear();

//                                       _circle.add(Circle(
//                                           circleId: CircleId('1'),
//                                           center: _initialcameraposition,
//                                           radius: zoom.toDouble() * 1000,
//                                           fillColor:
//                                               Colors.blue.withOpacity(0.4),
//                                           strokeColor: Colors.blue,
//                                           strokeWidth: 3));
//                                     });
//                                     initData();
//                                   }),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             height: 30,
//                             width: 30,
//                             child: Material(
//                               borderRadius: BorderRadius.circular(100),
//                               color:
//                                   zoom == 4 ? Color(0xffed5565) : Colors.grey,
//                               child: MaterialButton(
//                                   padding: new EdgeInsets.all(3.0),
//                                   child: Text('4k'),
//                                   onPressed: () {
//                                     setState(() {
//                                       zoom = 4;
//                                       _circle.clear();

//                                       _circle.add(Circle(
//                                           circleId: CircleId('1'),
//                                           center: _initialcameraposition,
//                                           radius: zoom.toDouble() * 1000,
//                                           fillColor:
//                                               Colors.blue.withOpacity(0.4),
//                                           strokeColor: Colors.blue,
//                                           strokeWidth: 3));
//                                     });
//                                     initData();
//                                   }),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
