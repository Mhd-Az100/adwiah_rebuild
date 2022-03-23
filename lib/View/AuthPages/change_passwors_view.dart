import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class CahngePasswordScreen extends StatefulWidget {
  @override
  _CahngePasswordScreenState createState() => _CahngePasswordScreenState();
}

class _CahngePasswordScreenState extends State<CahngePasswordScreen> {
  String email = '';
  bool showPasswd = true;

  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = false;
  var save = false;
  var passwordController = TextEditingController();
  var newpasswordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Header()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: FittedBox(child: Text('Change Password')),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25 -
                        MediaQuery.of(context).padding.top -
                        55,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0 +
                                          ((context.diagonalInches / 6.0)
                                                  .floorToDouble() *
                                              10),
                                      horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  hintText: 'Your Password',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Email';
                                  }
                                  return null;
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: TextFormField(
                                obscureText: showPasswd,
                                controller: newpasswordController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(showPasswd
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          showPasswd = !showPasswd;
                                        });
                                      }),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0 +
                                          ((context.diagonalInches / 6.0)
                                                  .floorToDouble() *
                                              10),
                                      horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  hintText: 'NewPassword',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      value != passwordController.text ||
                                      value.length < 6) {
                                    return 'Please Enter your password';
                                  }
                                  return null;
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          /* Material(
                            borderRadius: BorderRadius.circular(100),
                            child: MaterialButton(
                              disabledColor: Color(0xfff5C376D),
                              disabledElevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  side: BorderSide(color: Color(0xff5C376D))),
                              child: Text(
                                'Save',
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
                             
                          ),*/
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ))
                ]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom != 0 ? false : true,
        child: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
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
