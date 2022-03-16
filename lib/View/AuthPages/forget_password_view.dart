// ignore_for_file: prefer_const_constructors
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final email;
  ForgetPasswordScreen(this.email);
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = this.widget.email;
  }

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
                    'Forget Password',
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
                              fontFamily: 'cairo',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              height: 1.6),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0)),
                          hintText: 'Email',
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
