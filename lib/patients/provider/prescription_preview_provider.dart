import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/patients.dart';

TextEditingController medicineNameController = TextEditingController();
TextEditingController medicineQuantityController = TextEditingController();
TextEditingController medicineWhenController = TextEditingController();
TextEditingController medicineFrequencyController = TextEditingController();
TextEditingController medicineDurationController = TextEditingController();
String frequency = 'Daily';
DoseUnit quantityUnit = DoseUnit.tablet;

class PrescriptionPreviewProvider with ChangeNotifier {
  Hospital hospital =
      Hospital('Nephron Hospital', 'Budh Bazaar Moradabad', '99999 99999');

  // sample doctor details
  Doctor doctor = Doctor('Dr. Random', 'Nephrologist', [
    Timings('Mon', '10:00 AM', '11:00 AM'),
    Timings('Tue', '10:00 AM', '11:00 AM'),
    Timings('Wed', '10:00 AM', '11:00 AM'),
    Timings('Thu', '10:00 AM', '11:00 AM'),
  ]);

  // sample patient details
  Patient patient = Patient(
      age: 20,
      gender: Gender.Male,
      id: 1,
      mobileNo: '9996969696',
      name: 'Doctor');

  // sample complaints
  List<Complaint> complaints = [
    Complaint('Headache', 2, DurationUnit.days),
    Complaint('Fever', 3, DurationUnit.days),
    Complaint('Nausea', 1, DurationUnit.days),
  ];

  // sample advice
  String advice =
      'Take this medicine for 3 days.\n If you feel better, continue taking it for 2 more days.';

  String getAdvice() {
    String adviceString = '';
    List<String> adviceList = advice.split('\n');
    for (int i = 0; i < adviceList.length; i++) {
      adviceString += '• ${adviceList[i]}\n';
    }
    return adviceString;
  }

  List<Investigation> investigations = [];

  void addInvestigation(String tests, String notes) {
    investigations.add(Investigation(tests, notes));
    notifyListeners();
  }

  void updateInvestigation(String tests, String notes, int index) {
    investigations[index] = Investigation(tests, notes);
    notifyListeners();
  }

  void deleteInvestigation(int index) {
    investigations.removeAt(index);
    notifyListeners();
  }

  bool _editModeObservation = false;

  bool get editModeObservation => _editModeObservation;

  void seteditModeObservation(bool value) {
    _editModeObservation = value;
    notifyListeners();
  }

  bool _editModeInvest = false;

  bool get editModeInvest => _editModeInvest;

  void seteditModeInvest(bool value) {
    _editModeInvest = value;
    notifyListeners();
  }

  bool _editModeMedication = false;

  bool get editModeMedication => _editModeMedication;

  void seteditModeMedication(bool value) {
    _editModeMedication = value;
    notifyListeners();
  }

  DateTime prescriptionDate = DateTime.now();
  DateTime nextVisitDate = DateTime.now();

  //Observation tab variables

  List<Observation> observations = [];

  int editIndexObservation = -1;

  String _complaint = '';
  String get complaint => _complaint;
  set complaint(String value) {
    _complaint = value;
    notifyListeners();
  }

  ObservationDuration _sinceDuration = ObservationDuration.hours;
  ObservationDuration get sinceDuration => _sinceDuration;
  set sinceDuration(ObservationDuration value) {
    _sinceDuration = value;
    notifyListeners();
  }

  String ObservationtoString(ObservationDuration value) {
    switch (value) {
      case ObservationDuration.hours:
        return 'Hours';
      case ObservationDuration.days:
        return 'Days';
      case ObservationDuration.weeks:
        return 'Weeks';
      case ObservationDuration.months:
        return 'Months';
      case ObservationDuration.years:
        return 'Years';
      default:
        return 'Hours';
    }
  }

  ObservationDuration getObservationDuration(String value){
    switch (value) {
      case 'Hours':
        return ObservationDuration.hours;
      case 'Days':
        return ObservationDuration.days;
      case 'Weeks':
        return ObservationDuration.weeks;
      case 'Months':
        return ObservationDuration.months;
      case 'Years':
        return ObservationDuration.years;
      default:
        return ObservationDuration.hours;
    }
  }

  List<String> getListofObservationDuration() {
    List<String> observationDurations = [];
    for (ObservationDuration observationDuration
        in ObservationDuration.values) {
      observationDurations.add(ObservationtoString(observationDuration));
    }
    debugPrintSynchronously(observationDurations.toString());
    return observationDurations;
  }

  int _since = 0;
  int get since => _since;
  set since(int value) {
    _since = value;
    notifyListeners();
  }

  String _diagnosis = '';
  String get diagnosis => _diagnosis;
  set diagnosis(String value) {
    _diagnosis = value;
    notifyListeners();
  }

  String _observation = '';
  String get observation => _observation;
  set observation(String value) {
    _observation = value;
    notifyListeners();
  }

  void addObservation(String complaint, int since,
      ObservationDuration sinceDuration, String diagnosis, String observation) {
    observations.add(Observation(
        complaint: complaint,
        since: since.toString(),
        diagnosis: diagnosis,
        observation: observation,
        observationDuration: sinceDuration));
    notifyListeners();
  }

  void updateObservation(String complaint, int since,
      ObservationDuration sinceDuration, String diagnosis, String observation) {
    observations[editIndexObservation] = Observation(
        complaint: complaint,
        since: since.toString(),
        diagnosis: diagnosis,
        observation: observation,
        observationDuration: sinceDuration);
    notifyListeners();
  }

  void deleteObservation(int index) {
    observations.removeAt(index);
    notifyListeners();
  }

  //Investigation tab variables
  String _tests = '';
  String get tests => _tests;
  set tests(String value) {
    _tests = value;
    notifyListeners();
  }

  String _notes = '';
  String get notes => _notes;
  set notes(String value) {
    _notes = value;
    notifyListeners();
  }

  //Medication tab variables
  String _medicineName = '';
  List<Medicine> _medication = [];

  List<Medicine> get medication => _medication;

  set medication(List<Medicine> value) {
    _medication = value;
    notifyListeners();
  }

  DurationUnit getDurationUnit(String value){
    switch (value) {
      case 'Days':
        return DurationUnit.days;
      case 'Weeks':
        return DurationUnit.weeks;
      case 'Months':
        return DurationUnit.months;
      case 'Years':
        return DurationUnit.years;
      default:
        return DurationUnit.days;
    }
  }

  DoseUnit getQuantityUnit(String value){
    switch (value) {
      case 'mg':
        return DoseUnit.mg;
      case 'gm':
        return DoseUnit.gm;
      case 'drops':
        return DoseUnit.drops;
      case 'puff':
        return DoseUnit.puff;
      case 'sachet':
        return DoseUnit.sachet;
      case 'tablet':
        return DoseUnit.tablet;
      case 'teaspoon':
        return DoseUnit.teaspoon;
      case 'units':
        return DoseUnit.units;
      case 'ml':
        return DoseUnit.ml;
      case 'capsule':
        return DoseUnit.capsule;
      case 'units':
        return DoseUnit.units;
      default:
        return DoseUnit.mg;
    }
  }

  void addMedicine(Medicine medicine) {
    _medication.add(medicine);
    notifyListeners();
  }

  void updateMedicine(Medicine medicine, int index) {
    _medication[index] = medicine;
    notifyListeners();
  }

  void deleteMedicine(int index) {
    _medication.removeAt(index);
    notifyListeners();
  }

  void insertMedicine(int index,Medicine medicine){
    _medication.insert(index, medicine);
    notifyListeners();
  }

  String get medicineName => _medicineName;
  set medicineName(String value) {
    _medicineName = value;
    notifyListeners();
  }

  String _medicineWhen = 'Morning';
  String get medicineWhen => _medicineWhen;
  set medicineWhen(String value) {
    _medicineWhen = value;
    notifyListeners();
  }

  String _doseQuantity = '';
  String get doseQuantity => _doseQuantity;
  set doseQuantity(String value) {
    _doseQuantity = value;
    notifyListeners();
  }

  String _doseUnit = 'Tablet';
  String get doseUnit => _doseUnit;
  set doseUnit(String value) {
    _doseUnit = value;
    notifyListeners();
  }

  String getDoseUnitString(DoseUnit quantityUnit) {
    String quantityUnitString;

    switch (quantityUnit) {
      case DoseUnit.mg:
        quantityUnitString = 'mg';
        break;
      case DoseUnit.ml:
        quantityUnitString = 'ml';
        break;
      case DoseUnit.gm:
        quantityUnitString = 'gm';
        break;
      case DoseUnit.tablet:
        quantityUnitString = 'tablet';
        break;
      case DoseUnit.capsule:
        quantityUnitString = 'capsule';
        break;
      case DoseUnit.drops:
        quantityUnitString = 'drops';
        break;
      case DoseUnit.sachet:
        quantityUnitString = 'sachet';
        break;
      case DoseUnit.teaspoon:
        quantityUnitString = 'teaspoon';
        break;
      case DoseUnit.puff:
        quantityUnitString = 'puff';
        break;
      default:
        quantityUnitString = 'units';
    }
    return quantityUnitString;
  }

 static DoseUnit getDoseUnit(String value){
    DoseUnit doseUnit;
    switch (value) {
      case 'mg':
        doseUnit = DoseUnit.mg;
        break;
      case 'ml':
        doseUnit = DoseUnit.ml;
        break;
      case 'gm':
        doseUnit = DoseUnit.gm;
        break;
      case 'tablet':
        doseUnit = DoseUnit.tablet;
        break;
      case 'capsule':
        doseUnit = DoseUnit.capsule;
        break;
      case 'drops':
        doseUnit = DoseUnit.drops;
        break;
      case 'sachet':
        doseUnit = DoseUnit.sachet;
        break;
      case 'teaspoon':
        doseUnit = DoseUnit.teaspoon;
        break;
      case 'puff':
        doseUnit = DoseUnit.puff;
        break;
      default:
        doseUnit = DoseUnit.units;
    }
    return doseUnit;
  }
  // getListofQuantityUnits() returns a list of strings of all the quantity units
  List<DoseUnit> getListofQuantityUnits() {
    List<DoseUnit> quantityUnits = [];
    for (DoseUnit quantityUnit in DoseUnit.values) {
      quantityUnits.add(quantityUnit);
    }
    return quantityUnits;
  }

  String getDurationString(DurationUnit durationUnit) {
    String durationString;
    switch (durationUnit) {
      case DurationUnit.days:
        durationString = 'day(s)';
        break;
      case DurationUnit.weeks:
        durationString = 'week(s)';
        break;
      case DurationUnit.months:
        durationString = 'month(s)';
        break;
      case DurationUnit.years:
        durationString = 'year(s)';
        break;
      default:
        durationString = 'day(s)';
    }
    return durationString;
  }

  String getWhenString(When when){
    String whenString;
    switch (when) {
      case When.Morning:
        whenString = 'Morning';
        break;
      case When.Afternoon:
        whenString = 'Afternoon';
        break;
      case When.Evening:
        whenString = 'Evening';
        break;
      case When.Night:
        whenString = 'Night';
        break;
      case When.TwoTimesADay:
        whenString = '2 times a day';
        break;
      case When.ThreeTimesADay:
        whenString = '3 times a day';
        break;
      case When.FourTimesADay:
        whenString = '4 times a day';
        break;
      case When.FiveTimesADay:
        whenString = '5 times a day';
        break;
      case When.SixTimesADay:
        whenString = '6 times a day';
        break;
      case When.SOS:
        whenString = 'SOS';
        break;
      case When.STAT:
        whenString = 'STAT';
        break;
      case When.BeforeMeal:
        whenString = 'Before Meal';
        break;
      case When.AfterMeal:
        whenString = 'After Meal';
        break;
      case When.WithMeal:
        whenString = 'With Meal';
        break;
      case When.EmptyStomach:
        whenString = 'Empty Stomach';
        break;
      default:
        whenString = 'Morning';
    }
    return whenString;
  }

  String _repeat = 'Daily';
  String get repeat => _repeat;
  set repeat(String value) {
    _repeat = value;
    notifyListeners();
  }

  String _medicineFrequency = '';
  String get medicineFrequency => _medicineFrequency;
  set medicineFrequency(String value) {
    _medicineFrequency = value;
    notifyListeners();
  }

  String _specialInstructions = '';
  String get specialInstructions => _specialInstructions;
  set specialInstructions(String value) {
    _specialInstructions = value;
    notifyListeners();
  }

  String _alternateMedicine = '';
  String get alternateMedicine => _alternateMedicine;
  set alternateMedicine(String value) {
    _alternateMedicine = value;
    notifyListeners();
  }

  List<String> _diets = [];
  List<String> get diets => _diets;
  set diets(List<String> value) {
    _diets = value;
    notifyListeners();
  }

  String _forValue = '';
  String get forValue => _forValue;
  set forValue(String value) {
    _forValue = value;
    notifyListeners();
  }

  String _forUnit = 'Days';
  String get forUnit => _forUnit;
  set forUnit(String value) {
    _forUnit = value;
    notifyListeners();
  }

  //Diet and advice tab
  String _addDiet = '';
  String get addDiet => _addDiet;
  set addDiet(String value) {
    _addDiet = value;
    notifyListeners();
  }

  String _addAdvice = '';
  String get addAdvice => _addAdvice;
  set addAdvice(String value) {
    _addAdvice = value;
    notifyListeners();
  }

  //Next visit tab

  String _nextVisitAfter = '';
  String get nextVisitAfter => _nextVisitAfter;
  set nextVisitAfter(String value) {
    _nextVisitAfter = value;
    notifyListeners();
  }

  String _frequency = '';
  String get frequency => _frequency;
  set frequency(String value) {
    _frequency = value;
    notifyListeners();
  }

  // Define the controllers for the input fields
  // final complaintController = TextEditingController();
  // final sinceController = TextEditingController();
  // final observationController = TextEditingController();
  // final diagnosisController = TextEditingController();
  // final testsController = TextEditingController();
  // final notesController = TextEditingController(text: '•');
  // final medicineNameController = TextEditingController();
  // final doseQuantityController = TextEditingController();
  // final specialInstructionsController = TextEditingController();
  // final alternateMedicineController = TextEditingController();
  // final forController = TextEditingController();
  // final addDietController = TextEditingController(text: '•');
  // final addAdviceController = TextEditingController(text: '•');
  // final _bulletListController = TextEditingController(text: '•');
  // final physicalExaminationController = TextEditingController(text: '•');
  // final _diagnosisController = TextEditingController();
  // final nextVisitAfterController = TextEditingController();

  //for dropdown in observation
  // String sinceUnit = '';

  // String physicalExamination = '';

  // TextEditingController get bulletListController => _bulletListController;

  // TextEditingController get thediagnosisController => _diagnosisController;
}
