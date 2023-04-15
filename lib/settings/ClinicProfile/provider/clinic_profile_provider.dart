import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ClinicProfileProvider extends ChangeNotifier {
  Uint8List? _image;
  String _clinicName = '';
  String _clinicSpeciality = '';
  String _otherSpeciality = '';
  String _about = '';
  String _phoneNo1 = '';
  String _phoneNo2 = '';
  String _phoneNo3 = '';
  String _email = '';
  String _address = '';
  String _area = '';
  String _city = '';
  String _pinCode = '';
  bool _isChecked = false;

  Uint8List? get image => _image;
  String get clinicName => _clinicName;
  String get clinicSpeciality => _clinicSpeciality;
  String get otherSpeciality => _otherSpeciality;
  String get about => _about;
  String get phoneNo1 => _phoneNo1;
  String get phoneNo2 => _phoneNo2;
  String get phoneNo3 => _phoneNo3;
  String get email => _email;
  String get address => _address;
  String get area => _area;
  String get city => _city;
  String get pinCode => _pinCode;
  bool get isChecked => _isChecked;

  void setImage(Uint8List? image) {
    _image = image;
    log(_image.toString());
    notifyListeners();
  }

  void setClinicName(String text) {
    _clinicName = text;
    notifyListeners();
  }

  void setClinicSpeciality(String text) {
    _clinicSpeciality = text;
    notifyListeners();
  }

  void setOtherSpeciality(String text) {
    _otherSpeciality = text;
    notifyListeners();
  }

  void setAbout(String text) {
    _about = text;
    notifyListeners();
  }

  void setPhoneNo1(String text) {
    _phoneNo1 = text;
    notifyListeners();
  }

  void setPhoneNo2(String text) {
    _phoneNo2 = text;
    notifyListeners();
  }

  void setPhoneNo3(String text) {
    _phoneNo3 = text;
    notifyListeners();
  }

  void setEmail(String text) {
    _email = text;
    notifyListeners();
  }

  void setAddress(String text) {
    _address = text;
    notifyListeners();
  }

  void setArea(String text) {
    _area = text;
    notifyListeners();
  }

  void setCity(String text) {
    _city = text;
    notifyListeners();
  }

  void setPinCode(String text) {
    _pinCode = text;
    notifyListeners();
  }

  void setChecked(bool isChecked) {
    _isChecked = isChecked;
    notifyListeners();
  }
}
