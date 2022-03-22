import 'package:adwiah/Constants/constans.dart';
import 'package:adwiah/Utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sized_context/sized_context.dart';

class TextFeildPassWidget extends StatelessWidget {
  TextFeildPassWidget(
      {Key? key,
      required this.controller,
      required this.showPasswd,
      required this.txt})
      : super(key: key);
  TextEditingController? controller;
  String? txt;
  var showPasswd = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextFormField(
          obscureText: showPasswd.value,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(
                  showPasswd.value ? Icons.visibility : Icons.visibility_off,
                  color: Constants.purple,
                ),
                onPressed: () {
                  showPasswd.value = !showPasswd.value;
                }),
            contentPadding: EdgeInsets.symmetric(
                vertical: 10.0 +
                    ((context.diagonalInches / 6.0).floorToDouble() * 10),
                horizontal: 10.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide:
                    const BorderSide(color: Constants.purple, width: 2.0)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide:
                    const BorderSide(color: Constants.purple, width: 2.0)),
            hintText: txt,
          ),
          validator: (password) => Validator.validateLoginPassword(password),
        ));
  }
}
