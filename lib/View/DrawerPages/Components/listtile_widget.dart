import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class ListTileDrawer extends StatelessWidget {
  ListTileDrawer({
    required this.text,
    this.padding,
    this.colortxt,
    required this.ontap,
    Key? key,
  }) : super(key: key);
  String? text;
  void Function()? ontap;
  EdgeInsetsGeometry? padding;
  Color? colortxt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: SizedBox(
        height: context.diagonalInches < 7 ? 40 : 60,
        child: ListTile(
          onTap: ontap,
          title: Text(text!,
              style: TextStyle(color: colortxt ?? Colors.black, fontSize: 16)),
        ),
      ),
    );
  }
}
