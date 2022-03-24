import 'package:flutter/material.dart';

class BranIconRow extends StatelessWidget {
  final bg;
  final otc;
  final iconnumber;
  const BranIconRow(this.bg, this.otc, this.iconnumber);
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        child: bg == 'B'
            ? Image.asset('assets/images/B.png')
            : Image.asset('assets/images/G.png'),
        height: 25,
        width: 25,
      ),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        child: otc
            ? Image.asset(('assets/images/OTC.png'))
            : Image.asset(('assets/images/RX.png')),
        height: 25,
        width: 25,
      ),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        child: Image.asset(('assets/icons/$iconnumber.png')),
        height: 30,
        width: 30,
      )
    ]);
  }
}
