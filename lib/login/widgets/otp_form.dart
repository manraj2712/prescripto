import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_prescription_frontend/constants/responsive.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/login_signup_provider.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late Timer _timer;
  int _seconds = 60;
  int _otpLength = 5;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0)
          _seconds--;
        else
          _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Card(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.12),
      elevation: 10,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 20, left: 25),
              child: Text(
                "Enter OTP",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Consumer<LoginSignUpProvider>(
                        builder: (context, value, child) {
                          return RichText(
                            text: TextSpan(
                                text:
                                    "We have sent an OTP on your mobile\nnumber ",
                                style: TextStyle(
                                    fontSize: Responsive.isTablet(context)
                                        ? _textScaleFactor * 20
                                        : _textScaleFactor * 13),
                                children: [
                                  TextSpan(
                                    text:
                                        "${value.loginPhoneNumber.toString()} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1.5),
                                  ),
                                  if (value.signupDetails?.email != null)
                                    TextSpan(text: "and on your email\n"),
                                  if (value.signupDetails?.email != null)
                                    TextSpan(
                                        text:
                                            "${value.signupDetails?.email.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 1.5))
                                ]),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                ],
              ),
            ),
            Form(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20,
                ),
                // create _otpLength number of OtpNoBox
                for (int i = 0; i < _otpLength; i++) OtpNoBox(),
                SizedBox(
                  width: 20,
                )
              ],
            )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Enter OTP",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: _seconds != 0
                        ? Text(_seconds.toString() + " sec",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold))
                        : TextButton(onPressed: () {}, child: Text('Resend')),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: MyWidgets.ctaButton(
                  text: "Complete sign up",
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  }),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class OtpNoBox extends StatelessWidget {
  const OtpNoBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: _screenSize.height * 0.1,
      width: Responsive.isMobile(context)
          ? _screenSize.width * 0.1
          : Responsive.isDesktop(context)
              ? _screenSize.width * 0.04
              : _screenSize.width * 0.08,
      child: TextFormField(
        decoration: InputDecoration(border: OutlineInputBorder()),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) FocusScope.of(context).previousFocus();
        },
        style: Theme.of(context).textTheme.titleLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
