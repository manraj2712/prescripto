import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/models/prescription.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/models/vitals_model.dart';

import '../models/service_model.dart';

class SettingProvider with ChangeNotifier {
  //Prescription
  Map<String, bool> boolValue = {
    'Observations': true,
    'Vitals': false,
    'Medication': true,
    'Investigation': true,
    'Diet': true,
    'Advice': true,
    'Nextvisit': false
  };

  List<Prescription> get prescription => prescription;
  void setChecked(String title, bool value) {
    boolValue[title] = value;
    notifyListeners();
  }

  //vitals
  TextEditingController vitalsController = TextEditingController();
  List<Vitals> _records = [
    Vitals(name: 'Record 1'),
    Vitals(name: 'Record 2'),
    Vitals(name: 'Record 3'),
  ];

  List<Vitals> get records => _records;

  void addRecord(String name) {
    _records.add(Vitals(name: name));
    notifyListeners();
  }

  void deleteRecord(int index) {
    _records.removeAt(index);
    notifyListeners();
  }

  void sortRecords(bool ascending) {
    _records.sort((a, b) => a.name.compareTo(b.name) * (ascending ? 1 : -1));
    notifyListeners();
  }

  //services
  List<ServiceModel> _services = [
    ServiceModel(name: 'service 1', price: 50, creationDate: DateTime.now()),
    ServiceModel(name: 'service 2', price: 100, creationDate: DateTime.now()),
    ServiceModel(name: 'service 3', price: 150, creationDate: DateTime.now()),
  ];
  List<ServiceModel> get services => _services;

  void addService(ServiceModel service) {
    _services.add(service);
    notifyListeners();
  }

  void deleteService(ServiceModel service) {
    _services.remove(service);
    notifyListeners();
  }

  void editService(ServiceModel oldService, ServiceModel newService) {
    final index = _services.indexOf(oldService);
    _services[index] = newService;
    notifyListeners();
  }

  void sortServicesBy(String column, bool ascending) {
    int? result;
    _services.sort((a, b) {
      if (column == 'name') {
        result = a.name.compareTo(b.name);
      } else if (column == 'price') {
        result = a.price.compareTo(b.price);
      } else if (column == 'creationDate') {
        result = a.creationDate.compareTo(b.creationDate);
      }
      return ascending ? result! : -result!;
    });
    notifyListeners();
  }

  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<bool> _selectedDays = List.generate(8, (_) => false);

  List<bool> get selectedDays => _selectedDays;

  void toggleDay(int index) {
    _selectedDays[index] = !_selectedDays[index];
    notifyListeners();
  }

  //Sms/Whatsapp

  Map<String, bool> _switchState = {
    "When the patient is added to queue": true,
    "When the patient is checked out from the queue.": true,
    "Appointment Confirmation": true,
    "Appointment Cancellation": true,
    "Appointment Reschedule": true,
    "Appointment Reminder": true,
  };

  bool isSwitched(String text) {
    return _switchState[text] ?? false;
  }

  void updateSwitch(String text, bool value) {
    _switchState[text] = value;
    notifyListeners();
  }

  String unit = 'hours';
  double value = 0.0;
  void updateUnit(String newUnit) {
    unit = newUnit;
    notifyListeners();
  }

  void updateValue(double newValue) {
    value = newValue;
    notifyListeners();
  }

  //time provider for time_picker_text_field
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;

  set startTime(TimeOfDay newTime) {
    _startTime = newTime;
    notifyListeners();
  }

  set endTime(TimeOfDay newTime) {
    _endTime = newTime;
    notifyListeners();
  }
}
