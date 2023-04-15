import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/patients.dart';

class PatientProvider with ChangeNotifier {
  Gender _selectedGender = Gender.Male;

  //Add Patient Dialog
  String _firstName='';
  String _lastName='';
  int _age=0;
  String _mobileNo='';

  String get firstName => _firstName;

  String get lastName => _lastName;

  int get age => _age;

  String get mobileNo => _mobileNo;

  void setFirstName(String value){
    _firstName=value;
    notifyListeners();
  }

  void setLastName(String value){
    _lastName=value;
    notifyListeners();
  }

  void setAge(int value){
    _age=value;
    notifyListeners();
  }

  void setMobileNo(String value){
    _mobileNo=value;
    notifyListeners();
  }
  
  // final editPatientKey=GlobalKey<FormState>();

  bool _enabled = false;

  bool get enabled => _enabled;

  Gender get selectedGender => _selectedGender;

  void updateSelectedGender(Gender gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void setEnabled(bool enabled) {
    _enabled = enabled;
    notifyListeners();
  }

  List<Patient> patients = [
    Patient(
        id: 1,
        name: 'John',
        age: 20,
        gender: Gender.Male,
        mobileNo: '1234567890',
        lastVisit: DateTime(2022, 02, 10)),
    Patient(
        id: 2,
        name: 'Mary',
        age: 25,
        gender: Gender.Female,
        mobileNo: '0987654321',
        lastVisit: DateTime(2022, 03, 05)),
    Patient(
        id: 3,
        name: 'Bob',
        age: 30,
        gender: Gender.Male,
        mobileNo: '4567891230',
        lastVisit: DateTime(2022, 01, 15)),
  ];

  int sortById = 0;
  int sortByLastVisit = 0;
  int _sortById = 0;
  int _sortByLastVisit = 0;


  void addPatient(Patient patient) {
    patients.add(patient);
    notifyListeners();
  }

  void deletePatient(int id) {
    patients.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void editPatient(Patient patient) {
    int index = patients.indexWhere((element) => element.id == patient.id);
    patients[index] = patient;
    notifyListeners();
  }

  void setSortById(int value) {
    _sortById = value;
    notifyListeners();
  }

  void setSortByLastVisit(int value) {
    _sortByLastVisit = value;
    notifyListeners();
  }

  void sortList(List<Patient> patients) {
    patients.sort((a, b) {
      if (_sortById != 0) {
        int cmp = a.id.compareTo(b.id);
        return _sortById == 1 ? cmp : -cmp;
      } else if (_sortByLastVisit != 0) {
        // int cmp = a.lastVisit.compareTo(b.lastVisit);
        int cmp = DateFormat('dd-MM-yyyy')
            .format(a.lastVisit!)
            .compareTo(DateFormat('dd-MM-yyyy').format(b.lastVisit!));
        return _sortByLastVisit == 1 ? cmp : -cmp;
      } else {
        return 0;
      }
    });
    notifyListeners();
  }
}
