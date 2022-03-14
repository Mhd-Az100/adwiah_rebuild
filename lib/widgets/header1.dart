// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
        height: MediaQuery.of(context).size.height * 0.25,

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
                    colors: [Color(0x001d1d1d), Color(0xff1d1d1d)],
                  ),
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
                      child:
                          Image(image: AssetImage('assets/images/logo.png'))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
