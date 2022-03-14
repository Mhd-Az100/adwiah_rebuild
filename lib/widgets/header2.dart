// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Header2 extends StatefulWidget {
  @override
  _Header2State createState() => _Header2State();
}

class _Header2State extends State<Header2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
        height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80))),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80)),
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/midicenbackground.png"),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x001d1d1d), Color(0xff5c376d)],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
