import 'package:adwiah/View/DrawerPages/View_Model/changepassword_view_model.dart';
import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:adwiah/widgets/textfeildpass_widget.dart';
import 'package:adwiah/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

final ChangePasswordController ctrl = Get.find<ChangePasswordController>();

class _ChangePasswordState extends State<ChangePassword> {
  String? currentJob;
  // bool showPasswd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header()),
          Scaffold(
            drawer: NavDrawer(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              // actions: <Widget>[BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: FittedBox(
                  child: Text('Change Password',
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      style: const TextStyle(fontSize: 24))),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(children: <Widget>[
                SizedBox(height: 220 - MediaQuery.of(context).padding.top - 55),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20, 0.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: ctrl.chngpassFormKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              txtController: ctrl.passwordController,
                              hint: 'Your Password',
                              msgValidation: 'Please fill your password',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFeildPassWidget(
                              showPasswd: ctrl.showPasswd,
                              controller: ctrl.newpasswordController,
                              txt: 'New password',
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(100),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                    side: const BorderSide(
                                        color: Color(0xff5C376D))),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 22,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                height: 45,
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {},
                                color: const Color(0xff5C376D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 9),
          child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: BottomControllBar(0))),
    );
  }
}
