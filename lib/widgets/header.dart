import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
        height: MediaQuery.of(context).size.height * 0.25,

        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80))),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/midicenbackground.png"),
                      fit: BoxFit.cover)),
            ),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x001d1d1d), Color(0xff1d1d1d)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: const Image(
                          image: AssetImage('assets/images/logo.png'))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class Header2 extends StatefulWidget {
//   @override
//   _Header2State createState() => _Header2State();
// }

// class _Header2State extends State<Header2> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//       child: AnimatedContainer(
//         duration: Duration(seconds: 1),
//         // Provide an optional curve to make the animation feel smoother.
//         curve: Curves.fastOutSlowIn,
//         height: MediaQuery.of(context).size.height,

//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(80),
//                 bottomRight: Radius.circular(80))),
//         child: Stack(
//           fit: StackFit.expand,
//           alignment: Alignment.bottomCenter,
//           children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                 constraints: BoxConstraints.expand(),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(80),
//                         bottomRight: Radius.circular(80)),
//                     image: DecorationImage(
//                         image: AssetImage("assets/midicenbackground.png"),
//                         fit: BoxFit.cover)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//               child: AnimatedContainer(
//                 duration: Duration(seconds: 1),
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(80),
//                       bottomRight: Radius.circular(80)),
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Color(0x001d1d1d), Color(0xff5c376d)],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
