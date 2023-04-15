import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_prescription_frontend/constants/enums.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/home_screen.dart';
import 'package:online_prescription_frontend/login/models/signup.dart';
import 'package:online_prescription_frontend/login/providers/login_signup_provider.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  List<String> rolesList = [
    "Doctor",
    "Therapist",
    "Staff",
  ];
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late String designation;

  @override
  void initState() {
    SignupDetails? signupDetails =
        Provider.of<LoginSignUpProvider>(context, listen: false).signupDetails;

    if (signupDetails != null) {
      designation = signupDetails.designation.toLowerCase();
      nameController.text = signupDetails.name;
      emailController.text = signupDetails.email;
      mobileNoController.text = signupDetails.phoneNumber;
    } else {
      designation = rolesList[0].toLowerCase();
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
                child: Text("Create your Kulcare account",
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 8, bottom: 8),
                child: Text(
                  "I am,",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: DropdownButtonFormField(
                  style: GoogleFonts.openSans(),
                  items: dropdownItems,
                  value: designation,
                  onChanged: (value) {
                    setState(() {
                      designation = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select a role";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      ))),
                ),
              ),
              textFieldWithHeading(
                  heading: "Name",
                  controller: nameController,
                  hintText: "Name",
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter name";
                    }
                    if (value.length < 3) {
                      return "Name should be atleast 3 characters long.";
                    }
                    return null;
                  }),
              textFieldWithHeading(
                  heading: "Mobile number",
                  controller: mobileNoController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 10,
                  hintText: "Phone number",
                  keyboardType: TextInputType.number,
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
                  }),
              textFieldWithHeading(
                  heading: "Email",
                  controller: emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email address is required';
                    }
                    // checks for a valid email address
                    else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  }),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: MyWidgets.ctaButton(
                    text: "Get OTP",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // try {
                        //   await loginSignUpProvider.signup(SignupDetails(
                        //       email: emailController.text,
                        //       designation: designation,
                        //       name: nameController.text,
                        //       phoneNumber: mobileNoController.text));
                        loginSignUpProvider.signup(SignupDetails(
                            email: emailController.text,
                            designation: designation,
                            name: nameController.text,
                            phoneNumber: mobileNoController.text));
                        loginSignUpProvider.setLoginSignUp(LoginOrSignUp.otp);
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
                  Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        loginSignUpProvider.setLoginSignUp(LoginOrSignUp.login);
                      },
                      child: Text("Sign in"))
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  Column textFieldWithHeading(
      {required String heading,
      required TextEditingController controller,
      required String hintText,
      required TextInputType keyboardType,
      maxLength = 50,
      required String? Function(String?) validator,
      List<TextInputFormatter> inputFormatters = const []}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 8, bottom: 8),
          child: Text(
            heading,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 8),
          child: TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            // remove max length counter text
            buildCounter: (BuildContext context,
                    {int? currentLength, int? maxLength, bool? isFocused}) =>
                null,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[400])),
            validator: (newValue) {
              return validator(newValue);
            },
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    return rolesList
        .map((e) => DropdownMenuItem(
              child: Text(e),
              value: e.toLowerCase(),
            ))
        .toList();
  }
}
