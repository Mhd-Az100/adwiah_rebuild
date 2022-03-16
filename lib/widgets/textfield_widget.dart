import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {Key? key,
      required this.txtController,
      required this.hint,
      required this.msgValidation,
      this.validatoremail})
      : super(key: key);

  final TextEditingController txtController;
  String? hint;
  String? msgValidation;
  String? Function(String?)? validatoremail;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: txtController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical:
                  10.0 + ((context.diagonalInches / 6.0).floorToDouble() * 10),
              horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          hintText: hint),
      validator: validatoremail ??
          (value) {
            if (value!.isEmpty) {
              return msgValidation;
            }
            return null;
          },
    );
  }
}
