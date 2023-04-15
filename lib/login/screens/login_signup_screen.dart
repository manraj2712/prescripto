import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_prescription_frontend/constants/enums.dart';
import 'package:online_prescription_frontend/login/providers/login_signup_provider.dart';
import 'package:online_prescription_frontend/constants/responsive.dart';
import 'package:online_prescription_frontend/login/widgets/otp_form.dart';
import 'package:online_prescription_frontend/login/widgets/signup_form.dart';
import 'package:provider/provider.dart';

import '../widgets/login_form.dart';
import '../widgets/login_text.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    LoginSignUpProvider _loginSignUpProvider =
        Provider.of<LoginSignUpProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: Responsive.isDesktop(context),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Kulcare",
          style: GoogleFonts.lato(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20, bottom: 10),
            child: SizedBox(
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  animationDuration: Duration(milliseconds: 1000),
                  shape: BeveledRectangleBorder(),
                  backgroundColor: Colors.white,
                  elevation: 8,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  _loginSignUpProvider.setLoginSignUp(
                      _loginSignUpProvider.loginOrSignUp == LoginOrSignUp.login
                          ? LoginOrSignUp.signUp
                          : LoginOrSignUp.login);
                },
                child: Text(
                  _loginSignUpProvider.loginOrSignUp == LoginOrSignUp.login
                      ? "Sign Up"
                      : "Sign In",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Responsive(
          desktop: Column(children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 200),
                  child: LoginText(),
                )),
                Expanded(
                    child: _loginSignUpProvider.loginOrSignUp ==
                            LoginOrSignUp.login
                        ? LoginForm()
                        : _loginSignUpProvider.loginOrSignUp ==
                                LoginOrSignUp.signUp
                            ? SignUpForm()
                            : OtpForm()),
              ],
            )
          ]),
          mobile: _loginSignUpProvider.loginOrSignUp == LoginOrSignUp.login
              ? LoginForm()
              : _loginSignUpProvider.loginOrSignUp == LoginOrSignUp.signUp
                  ? SignUpForm()
                  : OtpForm(),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            '© 2021 kulcare. All rights reserved',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}

