// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class FloatTextBox extends StatelessWidget {
  final String title;
  final String body;
  const FloatTextBox(this.title, this.body, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40 +
                            ((context.diagonalInches / 6.0).floorToDouble() *
                                20),
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          body,
                          textScaleFactor: 1.0 +
                              (context.diagonalInches / 9.0).floorToDouble(),
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.topCenter,
              width: 270,
              height:
                  50 + ((context.diagonalInches / 6.0).floorToDouble() * 20),
              decoration: BoxDecoration(
                  color: const Color(0xff5C376D),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      title,
                      textScaleFactor:
                          1.0 + (context.diagonalInches / 9.0).floorToDouble(),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FloatBox extends StatelessWidget {
  final String? title;
  final Widget? body;
  double? scale;
  FloatBox(this.title, this.body, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    scale = context.diagonalInches;
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        height: 40 +
                            ((context.diagonalInches / 6.0).floorToDouble() *
                                20),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: body,
                  ),
                ],
              ),
            ),
          ],
        ),
        Center(
          child: Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width * 0.7,
            height: 50 + ((context.diagonalInches / 6.0).floorToDouble() * 20),
            decoration: BoxDecoration(
                color: const Color(0xff5C376D),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: FittedBox(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: scale! < 7 ? 16 : 30,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
