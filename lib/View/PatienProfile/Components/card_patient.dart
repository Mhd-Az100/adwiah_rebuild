import 'package:flutter/material.dart';

class PatienCard extends StatelessWidget {
  PatienCard({
    Key? key,
    required this.ontap,
    required this.iscomplate,
    required this.imgPath,
    required this.txt,
  }) : super(key: key);

  void Function()? ontap;
  bool iscomplate;
  String imgPath;
  String txt;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffffffff),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: (MediaQuery.of(context).size.width / 3) * 0.5,
                width: (MediaQuery.of(context).size.width / 3) * 0.5,
                child: Material(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xff5C376D),
                  child: IconButton(
                      padding: const EdgeInsets.all(4.0),
                      icon: Image.asset(
                        imgPath,
                        height:
                            (MediaQuery.of(context).size.width / 3) * 0.5 - 25,
                        width:
                            (MediaQuery.of(context).size.width / 3) * 0.5 - 25,
                      ),
                      onPressed: ontap),
                ),
              ),
              Flexible(
                  child: Text(txt,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff5C376D))))
            ],
          ),
        ),
      ),
    );
  }
}
