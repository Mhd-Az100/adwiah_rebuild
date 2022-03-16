import 'dart:ui';

import 'package:adwiah/View/AuthPages/View_Model/sign_up_view_model.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_app_view_model.dart';
import 'package:adwiah/utils/getPryvacyAndPolicy.dart';
import 'package:adwiah/utils/validator.dart';
import 'package:adwiah/widgets/textfeildpass_widget.dart';
import 'package:adwiah/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sized_context/sized_context.dart';

class SignUpForm extends StatelessWidget {
  final SignUpController controller = Get.find<SignUpController>();
  final InitialAppController ctrl = Get.find<InitialAppController>();

  @override
  Widget build(BuildContext context) {
    void showPrivacyDialog() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            title: SizedBox(
              width: double.infinity,
              child: Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.yellow[900]),
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: RichText(
                                    text: TextSpan(
                                        children: [
                                      TextSpan(text: getPrivacyAndPlicy('en'))
                                    ],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const FittedBox(
                              child: Text(
                                'Agree',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            height: 45,
                            onPressed: () {
                              controller.accept.value = true;

                              Navigator.of(context).pop();
                            },
                            color: Color(0xff5C376D),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const FittedBox(
                              child: Text(
                                'Ignore',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            height: 45,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            txtController: controller.f_nameController,
            hint: 'First Name',
            msgValidation: 'Please fill your first name',
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            txtController: controller.l_nameController,
            hint: 'Last Name',
            msgValidation: 'Please fill your last name',
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            txtController: controller.emailController,
            hint: 'E-mail',
            msgValidation: '',
            validatoremail: (email) => Validator.validateEmail(email),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            txtController: controller.phoneNumberController,
            hint: 'Phone Number',
            msgValidation: 'Please fill your phone number',
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: AlertDialog(
                        content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            return !ctrl.isEmpty.value
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: ctrl.proffisionslist.length,
                                        itemBuilder: (context, i) {
                                          return Obx(() => Row(
                                                children: [
                                                  Expanded(
                                                    child: ListTile(
                                                      title: Text(ctrl
                                                          .proffisionslist[i]
                                                          .name!),
                                                      onTap: () {
                                                        controller.currentJob
                                                                .value =
                                                            ctrl
                                                                .proffisionslist[
                                                                    i]
                                                                .name!;
                                                        controller
                                                                .proffision_nameController
                                                                .text =
                                                            ctrl
                                                                .proffisionslist[
                                                                    i]
                                                                .name!;

                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  controller.currentJob.value ==
                                                          ctrl
                                                              .proffisionslist[
                                                                  i]
                                                              .name!
                                                      ? SizedBox(
                                                          height: 10,
                                                          width: 10,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .purple,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                          ),
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ));
                                        }),
                                  )
                                : const Text('Proffision is Empty');
                          }),
                        ],
                      ),
                    )),
                  );
                },
              );
            },
            child: IgnorePointer(
              child: TextFieldWidget(
                txtController: controller.proffision_nameController,
                hint: 'Profession',
                msgValidation: 'Please fill your profession',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFeildPassWidget(
            showPasswd: controller.showpass,
            controller: controller.passwordController,
            txt: 'password',
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() => CheckboxListTile(
                value: controller.accept.value,
                onChanged: (value) {
                  showPrivacyDialog();
                },
                activeColor: Colors.white38,
                checkColor: Color(0xff5C376D),
                subtitle: RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  maxLines: 4,
                  text: const TextSpan(
                      children: [
                        TextSpan(
                            text:
                                'By creating an account you agree to our Terms of Service and Privacy Policy'),
                      ],
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0xff5C376D),
                      )),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Material(
            borderRadius: BorderRadius.circular(100),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  side: const BorderSide(color: Color(0xff5C376D))),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 22,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                ),
              ),
              height:
                  45 + ((context.diagonalInches / 6.0).floorToDouble() * 15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                controller.register();
              },
              color: const Color(0xff5C376D),
            ),
          ),
        ],
      ),
    );
  }
}
