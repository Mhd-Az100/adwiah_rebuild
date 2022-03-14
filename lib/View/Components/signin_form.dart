import 'package:adwiah/View/AuthPages/View_Model/sign_in_view_model.dart';
import 'package:adwiah/View/AuthPages/forget_password_view.dart';
import 'package:adwiah/constants/constans.dart';
import 'package:adwiah/utils/validator.dart';
import 'package:adwiah/widgets/textfield_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sized_context/sized_context.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool showPasswd = true;

  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = false;
  var save = false;

  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signInFormKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            child: TextFieldAuth(
              txtController: controller.emailController,
              hint: 'E-mail',
              msgValidation: 'Please fill your first name',
              validatoremail: (email) => Validator.validateEmail(email),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: showPasswd,
            controller: controller.passwordController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    showPasswd ? Icons.visibility : Icons.visibility_off,
                    color: Constants.purple,
                  ),
                  onPressed: () {
                    setState(() {
                      showPasswd = !showPasswd;
                    });
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
              hintText: 'Password',
            ),
            validator: (password) => Validator.validateLoginPassword(password),
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                    activeColor: Color(0xffed5565),
                    value: this.save,
                    onChanged: (value) {
                      setState(() {
                        this.save = value!;
                      });
                    }),
                const FittedBox(
                  child: Text(
                    'Remember me  ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1c2340),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen(
                                  controller.emailController.text)));
                    },
                    child: const Text(
                      'Forget Password ?',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xffE66088),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            borderRadius: BorderRadius.circular(100),
            child: MaterialButton(
              disabledColor: const Color(0xfff5C376D),
              disabledElevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  side: const BorderSide(color: Color(0xff5C376D))),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                ),
              ),
              height:
                  45 + ((context.diagonalInches / 6.0).floorToDouble() * 15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                controller.login();
                controller.isLoading.value ? Constants.looder : Get.back();
              },
              color: (!_isButtonDisabled
                  ? Color(0xfff5C376D)
                  : Color(0xfff5C376D)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
