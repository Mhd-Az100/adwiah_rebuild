// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:adwiah/Models/mediacal_centers.dart';
import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/View/AuthPages/View_Model/sign_in_view_model.dart';
import 'package:adwiah/View/DrawerPages/Components/listtile_widget.dart';
import 'package:adwiah/View/DrawerPages/Components/patientprofile_widgets.dart';
import 'package:adwiah/View/DrawerPages/Components/social_icons_widget.dart';
import 'package:adwiah/View/DrawerPages/View_Model/editprofile_view_model.dart';
import 'package:adwiah/View/DrawerPages/about_view.dart';
import 'package:adwiah/View/DrawerPages/adwiah_icons_view.dart';
import 'package:adwiah/View/DrawerPages/changepassword_view.dart';
import 'package:adwiah/View/DrawerPages/countries_view.dart';
import 'package:adwiah/View/DrawerPages/edit_profile_view.dart';
import 'package:adwiah/View/DrawerPages/medician_centers_view.dart';
import 'package:adwiah/View/DrawerPages/news_letters_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sized_context/sized_context.dart';
import 'package:url_launcher/url_launcher.dart';

class NavDrawer extends StatelessWidget {
  EditProfileController controller = Get.find<EditProfileController>();
  SignInController ctrl = Get.find<SignInController>();
  StorageHelperController storagectrl = Get.find<StorageHelperController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.diagonalInches > 7
          ? MediaQuery.of(context).size.width * 0.6
          : MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Container(
          color: Colors.white70,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: ListView(children: [
                    SizedBox(
                      height: 200,
                      child: Obx(() => UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                            ),
                            accountName: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 10),
                              child: SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        storagectrl.f_name.value +
                                            ' ' +
                                            storagectrl.l_name.value,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            accountEmail: Text(storagectrl.email.value,
                                style: TextStyle(color: Colors.black)),
                            currentAccountPicture: controller.filenull.value
                                ? CircleAvatar(
                                    minRadius: 70,
                                    backgroundImage:
                                        AssetImage('assets/icons/6.png'),
                                    backgroundColor: Colors.grey[900])
                                : CircleAvatar(
                                    minRadius: 70,
                                    backgroundImage: FileImage(controller.file),
                                    backgroundColor: Colors.grey[900]),
                          )),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [Color(0xff5c376d), Color(0xffe66189)],
                            ),
                          ),
                        )),
                    ExpansionTile(
                      title: Text('User Profile',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      children: [
                        ListTileDrawer(
                          text: 'Edit Profile',
                          ontap: () {
                            Get.find<EditProfileController>().fillolddata();
                            Get.to(() => EditProfileScreen());
                          },
                        ),
                        ListTileDrawer(
                          text: 'Edit Photo',
                          ontap: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: AlertDialog(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Color(0xff5C376D),
                                              ),
                                              Text('Edit'),
                                            ],
                                          ),
                                          onPressed: () {
                                            controller
                                                .imgPick(ImageSource.gallery);

                                            VoidCallback onStartUpload = () {
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 10, sigmaY: 10),
                                                    child: AlertDialog(
                                                        content: SizedBox(
                                                            height: 50,
                                                            child: Center(
                                                                child:
                                                                    CircularProgressIndicator()))),
                                                  );
                                                },
                                              );
                                            };
                                            VoidCallback onFinishUpload = () {
                                              Navigator.of(context).pop();
                                            };

                                            Navigator.pop(context);
                                          },
                                        ),
                                        SizedBox(width: 20),
                                        MaterialButton(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.image,
                                                color: Color(0xff5C376D),
                                              ),
                                              Text('Show')
                                            ],
                                          ),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 10, sigmaY: 10),
                                                  child: AlertDialog(
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(Icons
                                                                    .close))
                                                          ],
                                                        ),
                                                        // imageUrl != null
                                                        //     ? Image.network(
                                                        //         imageUrl,
                                                        //       )
                                                        //     :
                                                        Text(
                                                            'No Profile Image'),
                                                      ],
                                                    ),
                                                    actions: <Widget>[],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          disabledColor: Color(0xfffa788d),
                                          color: Color(0xff5C376D),
                                          disabledElevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Color(0xff5C376D))),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 22,
                                              color: const Color(0xffffffff),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          height: 45,
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        ListTileDrawer(
                          text: 'Patient Profile',
                          ontap: () {
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
                                      'Patient Profile',
                                      style:
                                          TextStyle(color: Colors.yellow[900]),
                                    ),
                                  ),
                                  content: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: PatientProfileWidgets(),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          'OK',
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
                                        Navigator.pop(context);
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             PatientHome()));
                                      },
                                      color: Color(0xff5C376D),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        ListTileDrawer(
                          text: 'Change Password',
                          ontap: () {
                            Get.to(() => ChangePassword());
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('About',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      children: [
                        ListTileDrawer(
                          text: 'About the app',
                          ontap: () {
                            Get.to(() => AboutScreen());
                          },
                        ),
                        ListTileDrawer(
                          text: 'Adwiah Icons',
                          ontap: () {
                            Get.to(() => AdwiahIcons());
                          },
                        ),
                        ListTileDrawer(
                          text: 'Demo',
                          ontap: () {},
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        'Additional Services',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      children: [
                        ListTileDrawer(
                          text: 'News Letters',
                          ontap: () {
                            Get.to(() => NewsLetters());
                          },
                        ),
                        ListTileDrawer(
                          text: 'Health Medical websites',
                          ontap: () {
                            Get.to(() => MedicalWebsites());
                          },
                        ),
                        ListTileDrawer(
                          text: 'Notifications',
                          ontap: () {},
                        ),
                      ],
                    ),
                    ListTileDrawer(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                      text: 'Select Country',
                      ontap: () {
                        Get.to(() => Countries());
                      },
                    ),
                    ListTileDrawer(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                      text: 'Contact Us',
                      ontap: () async {
                        var url = 'mailto:info@adwiah.net';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    ListTileDrawer(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                      colortxt: Colors.red,
                      text: 'Exit',
                      ontap: () {},
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SocialIcons(),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Powered By '),
                        ],
                      ),
                      Center(
                        child: Text('Copy Rights © '),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
