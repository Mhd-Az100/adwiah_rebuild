import 'package:adwiah/View/Home/home_view.dart';
import 'package:flutter/material.dart';

class BottomControllBar extends StatelessWidget {
  final index;
  BottomControllBar(this.index);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        this.index == 0
            ? Expanded(
                child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    child: IconButton(
                        iconSize: 35,
                        icon: Image.asset('assets/images/back.png'),
                        onPressed: () => Navigator.pop(context))),
              )
            : Expanded(
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
        Expanded(
          child: Material(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10),
              child: IconButton(
                  iconSize: 35,
                  icon: Image.asset('assets/images/home.png'),
                  onPressed: () {
                    if (this.index != 1) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false);
                    }
                  })),
        ),
        Expanded(child: SizedBox())
      ],
    );
  }
}
