import 'package:adwiah/View/AuthPages/Components/signin_form.dart';
import 'package:adwiah/View/AuthPages/Components/signup_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen>
    with SingleTickerProviderStateMixin {
  bool login = false;
  bool signup = false;
  late bool loginregistervisible;
  var loginregisterheight;
  late BorderRadius loginrgesterradius;
  String date = '';
  var type = '';

  @override
  void initState() {
    super.initState();
    date = DateTime.now().year.toString();
    if (type == 'login') {
      loginrgesterradius = const BorderRadius.only(
          bottomLeft: Radius.circular(80), bottomRight: Radius.circular(80));

      loginregistervisible = false;
      signup = false;
      login = true;
    } else {
      loginregistervisible = true;
      loginrgesterradius = BorderRadius.circular(0.0);
    }
  }

  void signinanimate() async {
    loginregistervisible
        ? setState(() {
            loginrgesterradius = const BorderRadius.only(
                bottomLeft: const Radius.circular(80),
                bottomRight: Radius.circular(80));
            loginregisterheight = MediaQuery.of(context).size.height / 2.2;
            loginregistervisible = false;
            signup = false;
            login = false;
          })
        : setState(() {
            loginrgesterradius = BorderRadius.circular(0.0);
            loginregisterheight = MediaQuery.of(context).size.height / 2.2;
            loginregistervisible = true;
            signup = false;
            login = false;
          });
  }

  void signupanimate() {
    loginregistervisible
        ? setState(() {
            loginrgesterradius = const BorderRadius.only(
                bottomLeft: const Radius.circular(80),
                bottomRight: Radius.circular(80));
            loginregisterheight = MediaQuery.of(context).size.height / 3;
            loginregistervisible = false;
            signup = false;
            login = false;
          })
        : setState(() {
            loginrgesterradius = BorderRadius.circular(0.0);
            loginregisterheight = MediaQuery.of(context).size.height / 3;
            loginregistervisible = true;
            signup = false;
            login = false;
          });
  }

  @override
  Widget build(BuildContext context) {
    if (type == 'login') {
      loginregisterheight = MediaQuery.of(context).size.height / 2.2;
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: loginregistervisible
                        ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
                        : const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      // Provide an optional curve to make the animation feel smoother.
                      curve: Curves.fastOutSlowIn,
                      height: loginregistervisible
                          ? MediaQuery.of(context).size.height
                          : loginregisterheight,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80))),
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: loginregistervisible
                                ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
                                : const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              constraints: const BoxConstraints.expand(),
                              decoration: BoxDecoration(
                                  borderRadius: loginrgesterradius,
                                  image: const DecorationImage(
                                      image: const AssetImage(
                                          "assets/images/midicenbackground.png"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding: loginregistervisible
                                ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
                                : const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                borderRadius: loginrgesterradius,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: loginregistervisible
                                      ? [
                                          const Color(0x001d1d1d),
                                          const Color(0x001d1d1d),
                                          const Color(0xff5c376d),
                                          const Color(0xff5c376d)
                                        ]
                                      : [
                                          const Color(0x001d1d1d),
                                          const Color(0xff1d1d1d)
                                        ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/images/logo.png'))),
                              const SizedBox(height: 60),
                              loginregistervisible
                                  ? AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      // Provide an optional curve to make the animation feel smoother.
                                      curve: Curves.fastOutSlowIn,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MaterialButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              signinanimate();
                                              setState(() {
                                                login = true;
                                              });
                                            },
                                            height: 50 +
                                                ((context.diagonalInches / 6.0)
                                                        .floorToDouble() *
                                                    15),
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                side: const BorderSide(
                                                    color: Colors.white)),
                                            child: const Text(
                                              'Login',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff1D1D1D)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          MaterialButton(
                                            color: const Color(0xffE66189),
                                            onPressed: () {
                                              signupanimate();
                                              setState(() {
                                                signup = true;
                                              });
                                            },
                                            height: 50 +
                                                ((context.diagonalInches / 6.0)
                                                        .floorToDouble() *
                                                    15),
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: const Text(
                                              'Register',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              !loginregistervisible
                                  ? SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            if (signup) {
                                              signupanimate();
                                            } else {
                                              signinanimate();
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  login
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            children: [
                              SignInForm(),
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'Don`t have an account ? ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        signinanimate();
                                        signupanimate();
                                        setState(() {
                                          signup = true;
                                        });
                                      },
                                      child: const Text(
                                        'Register !',
                                        style: TextStyle(
                                            color: Color(0xffE66088),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 19),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ))
                      : const SizedBox(),
                  signup
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            children: [
                              SignUpForm(),
                              const SizedBox(
                                height: 30,
                              ),
                              RichText(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  text: TextSpan(children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Already have an account?  ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    TextSpan(
                                        text: 'Sign in !',
                                        style: const TextStyle(
                                            color: Color(0xffed5565),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            if (signup) {
                                              signupanimate();
                                              signinanimate();
                                              setState(() {
                                                login = true;
                                              });
                                            }
                                          })
                                  ])),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ))
                      : const SizedBox()
                ],
              ),
            ),
          ),
          login || signup
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Powered By  '),
                        Image.asset(
                          'assets/images/smart.png',
                          height: 27,
                        )
                      ],
                    ),
                    Center(
                      child: Text('Copy Rights  © ' + date),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
