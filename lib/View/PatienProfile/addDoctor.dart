import 'package:adwiah/Utils/db_helper.dart';
import 'package:adwiah/View/Barcode/barcodeReader.dart';
import 'package:adwiah/View/Drawer/drawer_view.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class AddDoctor extends StatefulWidget {
  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  var nameController = TextEditingController();
  var specialityController = TextEditingController();
  var phoneController = TextEditingController();
  var mobileController = TextEditingController();
  var addressController = TextEditingController();
  var lang = "en";

  void saveDoctor() async {
    FocusScope.of(context).requestFocus(FocusNode());

    DoctorModel doctor = DoctorModel(
      name: nameController.text,
      specialization: specialityController.text,
      phone: phoneController.text,
      mobile: mobileController.text,
      address: addressController.text,
    );

    var resultSaveDoctor = await DatabaseHelper.instance!.addDoctor(doctor);
    print("resultSaveDoctor : $resultSaveDoctor");
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header2()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text('Add Doctor')),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(children: <Widget>[
                  SizedBox(
                      height: 220 - MediaQuery.of(context).padding.top - 55),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0 +
                                      ((context.diagonalInches / 6.0)
                                              .floorToDouble() *
                                          10),
                                  horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              hintText: lang == "en"
                                  ? 'Doctor\'s Name'
                                  : "أسم الطبيب",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: specialityController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0 +
                                      ((context.diagonalInches / 6.0)
                                              .floorToDouble() *
                                          10),
                                  horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              hintText:
                                  lang == "en" ? 'Speciality' : 'الاختصاص',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0 +
                                      ((context.diagonalInches / 6.0)
                                              .floorToDouble() *
                                          10),
                                  horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              hintText: 'Phone Number',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0 +
                                      ((context.diagonalInches / 6.0)
                                              .floorToDouble() *
                                          10),
                                  horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              hintText: 'Mobile Number',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0 +
                                      ((context.diagonalInches / 6.0)
                                              .floorToDouble() *
                                          10),
                                  horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              hintText: 'Address',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Address';
                              }
                              return null;
                            }),
                        SizedBox(height: 10),
                        Material(
                            borderRadius: BorderRadius.circular(100),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  side: BorderSide(color: Color(0xff5C376D))),
                              child: Text(
                                'Done',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 22,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              height: 45 +
                                  ((context.diagonalInches / 6.0)
                                          .floorToDouble() *
                                      15),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: saveDoctor,
                              color: Color(0xff5C376D),
                            ))
                      ],
                    ),
                  ))
                ]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
          child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: BottomControllBar(0))),
    );
  }
}
