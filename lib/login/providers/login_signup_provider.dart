import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/constants/enums.dart';
import 'package:online_prescription_frontend/login/api_function_calls.dart';
import 'package:online_prescription_frontend/login/models/signup.dart';

class LoginSignUpProvider with ChangeNotifier {
  LoginOrSignUp _loginOrSignUp = LoginOrSignUp.login;
  SignupDetails? _signupDetails;
  ApiFunctionCalls _apiFunctionCalls = ApiFunctionCalls();
  String? _loginPhoneNumber;

  String? get loginPhoneNumber => _loginPhoneNumber;
  SignupDetails? get signupDetails => _signupDetails;
  LoginOrSignUp get loginOrSignUp => _loginOrSignUp;

  login(String phoneNumber) async {
    // await _apiFunctionCalls.login(phoneNumber);
    _loginPhoneNumber = phoneNumber;
    notifyListeners();
  }

  setLoginSignUp(LoginOrSignUp loginOrSignUp) {
    _loginOrSignUp = loginOrSignUp;
    notifyListeners();
  }

  signup(SignupDetails signupDetails) async {
    // await _apiFunctionCalls.signup(signupDetails);
    _signupDetails = signupDetails;
    login(signupDetails.phoneNumber);
    notifyListeners();
  }
}
