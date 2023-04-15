import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_prescription_frontend/constants/enums.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/home_screen.dart';
import 'package:online_prescription_frontend/login/providers/login_signup_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController mobileNoController = TextEditingController();

  @override
  void initState() {
    String? loginPhoneNumber =
        Provider.of<LoginSignUpProvider>(context, listen: false)
            .loginPhoneNumber;
    if (loginPhoneNumber != null) {
      mobileNoController.text = loginPhoneNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // create a form key
    final _formKey = GlobalKey<FormState>();
    LoginSignUpProvider loginSignUpProvider =
        Provider.of<LoginSignUpProvider>(context, listen: false);
    return Card(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.12),
      elevation: 10,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 20, left: 25),
              child: Text(
                "Sign in to your account",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 8, bottom: 8),
              child: Text(
                "Mobile number",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.ptSans().toString()),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 8),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 10,
                // remove max length counter text
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter mobile number";
                  } else if (value.length != 10) {
                    return "Please enter valid mobile number";
                  }
                  // checks for valid indian mobile number that starts with 6,7,8,9
                  else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                    return 'Enter a valid Indian mobile number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: mobileNoController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(),
                    hintText: "Phone number",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: MyWidgets.ctaButton(
                  text: "Get OTP",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      loginSignUpProvider.setLoginSignUp(LoginOrSignUp.otp);
                      loginSignUpProvider.login(mobileNoController.text);
                      // try {
                      //   await loginSignUpProvider
                      //       .login(mobileNoController.text);
                      // } catch (e) {
                      //   MyWidgets.showSnackBar(context, e.toString());
                      // }
                    }
                  }),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don\'t have an account?"),
                TextButton(
                    onPressed: () {
                      loginSignUpProvider.setLoginSignUp(LoginOrSignUp.signUp);
                    },
                    child: Text("Signup"))
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
