import 'dart:ui';

import 'package:adwiah/View/Drawer/View_Model/editprofile_view_model.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:adwiah/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

EditProfileController controller = Get.put(EditProfileController());
final InitialAppController ctrl = Get.find<InitialAppController>();

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? currentJob;

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
                  child: Text('Edit Profile',
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
                        key: controller.editprofFormKey,
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
                              txtController: controller.phoneNumberController,
                              hint: 'Phone Number',
                              msgValidation: 'Please fill your phone number',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: AlertDialog(
                                          content: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 300,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Obx(() {
                                              return !ctrl.isEmpty.value
                                                  ? Expanded(
                                                      child: ListView.builder(
                                                          itemCount: ctrl
                                                              .proffisionslist
                                                              .length,
                                                          itemBuilder:
                                                              (context, i) {
                                                            return Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      ListTile(
                                                                    title: Text(ctrl
                                                                        .proffisionslist[
                                                                            i]
                                                                        .name!),
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        currentJob = ctrl
                                                                            .proffisionslist[i]
                                                                            .name!;
                                                                        controller
                                                                            .proffision_nameController
                                                                            .text = ctrl.proffisionslist[i].name!;
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ),
                                                                currentJob ==
                                                                        ctrl.proffisionslist[i]
                                                                            .name!
                                                                    ? SizedBox(
                                                                        height:
                                                                            10,
                                                                        width:
                                                                            10,
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.purple,
                                                                              borderRadius: BorderRadius.circular(50)),
                                                                        ),
                                                                      )
                                                                    : const SizedBox()
                                                              ],
                                                            );
                                                          }),
                                                    )
                                                  : Text('Proffision is Empty');
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
                                  txtController:
                                      controller.proffision_nameController,
                                  hint: 'Profession',
                                  msgValidation: 'Please fill your profession',
                                ),
                              ),
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
                                onPressed: () {
                                  controller.updateuser();
                                },
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
      bottomNavigationBar: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom != 0 ? false : true,
        child: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 9),
            child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: BottomControllBar(0))),
      ),
    );
  }
}
