import 'package:flutter/material.dart';

class CurvedBg1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 140.0,
      ),
      painter: CurvedBg1Painter(),
    );
  }
}

class CurvedBg1Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.quadraticBezierTo(size.width * 0.03, size.height * 0.50,
        size.width * 0.2, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.50,
        size.width * 0.8, size.height * 0.5);

    path.quadraticBezierTo(
        size.width * 0.97, size.height * 0.50, size.width * 1, size.height * 1);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height * 0.0);

    path.close();

    paint.color = Color(0xff1c2340);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CurvedBg2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 110.0,
      ),
      painter: CurvedBg2Painter(),
    );
  }
}

class CurvedBg2Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.moveTo(size.width * 0, size.height);
    path.quadraticBezierTo(size.width * 0.03, size.height * 0.50,
        size.width * 0.2, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.50,
        size.width * 0.8, size.height * 0.5);

    path.quadraticBezierTo(
        size.width * 0.97, size.height * 0.50, size.width * 1, size.height * 0);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height * 1.0);

    path.close();

    paint.color = Color(0xff1c2340);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BigBottomCurve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: (MediaQuery.of(context).size.height * 0.5) + 60,
      ),
      painter: BigBottomCurvePainter(),
    );
  }
}

class BigBottomCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.quadraticBezierTo(size.width * 0.03, 60, size.width * 0.2, 60);
    path.quadraticBezierTo(size.width * 0.2, 60, size.width * 0.8, 60);

    path.quadraticBezierTo(size.width * 0.97, 60, size.width * 1, 120);
    path.quadraticBezierTo(size.width, 100, size.width, size.height);
    path.quadraticBezierTo(size.width, size.height, 0, size.height);

    path.close();

    paint.color = Color(0xff1c2340);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BigBottomCurve2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: (MediaQuery.of(context).size.height * 0.5) + 100,
      ),
      painter: BigBottomCurve2Painter(),
    );
  }
}

class BigBottomCurve2Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.moveTo(size.width, 0);
    path.quadraticBezierTo(size.width - (size.width * 0.10), 60,
        size.width - (size.width * 0.3), 60);
    path.quadraticBezierTo(size.width - (size.width * 0.30), 60,
        size.width - (size.width * 0.7), 60);

    path.quadraticBezierTo(size.width * 0.1, 60, size.width * 0, 120);
    path.quadraticBezierTo(0, 100, 0, size.height);
    path.quadraticBezierTo(0, size.height, size.width, size.height);

    path.close();

    paint.color = Color(0xff1c2340);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CurvedBg1Reversed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 140.0,
      ),
      painter: CurvedBg1ReversedPainter(),
    );
  }
}

class CurvedBg1ReversedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.moveTo(size.width, 0);
    path.quadraticBezierTo(size.width * 0.97, size.height * 0.50,
        size.width * 0.8, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.70, size.height * 0.50,
        size.width * 0.2, size.height * 0.5);

    path.quadraticBezierTo(
        size.width * 0.03, size.height * 0.50, 0, size.height * 1);
    path.quadraticBezierTo(0, size.height, 0, size.height * 0.0);

    path.close();

    paint.color = Color(0xff1c2340);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
