import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/settings/Users/model/user_model.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [
    UserModel(name: "Dummy", gender: "M", mobileNo: 9999999999.toString()),
    UserModel(name: "Dummy", gender: "M", mobileNo: 9999999999.toString()),
    UserModel(name: "Dummy", gender: "M", mobileNo: 9999999999.toString()),
    UserModel(name: "Dummy", gender: "M", mobileNo: 9999999999.toString()),
  ];

  List<UserModel> get users => _users;

  void addUser(UserModel user) {
    _users.add(user);
    notifyListeners();
  }

  void updateStatus(int index, bool joined) {
    _users[index].joined = joined;
    notifyListeners();
  }
}
