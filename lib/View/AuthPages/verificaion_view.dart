// ignore_for_file: prefer_const_constructors
import 'package:adwiah/View/AuthPages/View_Model/verification_view_model.dart';
import 'package:adwiah/utils/validator.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Verification extends StatelessWidget {
  Verification(this.email, {Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final VerificatioController controller = Get.put(VerificatioController());
  final email;
  bool sended = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 220,
            child: Header(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.transparent, //change your color here
              ),
              title: Align(
                child: FittedBox(
                  child: Text(
                    'Verification Code',
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'cairo',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                alignment: Alignment.centerRight,
              ),
              backgroundColor: Colors.transparent,
            ),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: 260,
                        child: Text(
                          'We will send the code to The email that you have Registered To recover the password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              height: 1.6),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      child: Form(
                        key: controller.verifyFormKey,
                        child: Column(
                          children: [
                            SizedBox(
                              child: TextFormField(
                                controller: controller.codeController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  hintText: 'code',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your code';
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Color(0xff5C376D))),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 22,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        height: 48,
                        minWidth: MediaQuery.of(context).size.width,
                        color: Color(0xff5C376D),
                        onPressed: () {
                          controller.verify(emaill: email);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'If you dont get the code ',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.resendcode(emaill: email);
                            },
                            child: const Text(
                              'Resend ',
                              style: TextStyle(
                                  color: Color(0xffE66088),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
