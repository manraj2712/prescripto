import 'dart:convert';

enum DurationUnit { days, weeks, months, years }

enum ObservationDuration { hours, days, weeks, months, years }

enum When {
  Morning,
  Afternoon,
  Evening,
  Night,
  TwoTimesADay,
  ThreeTimesADay,
  FourTimesADay,
  FiveTimesADay,
  SixTimesADay,
  SOS,
  STAT,
  BeforeMeal,
  AfterMeal,
  WithMeal,
  EmptyStomach,
}
// 'Morning',
//                             'Afternoon',
//                             'Evening',
//                             'Night',
//                             '2 times a day',
//                             '3 times a day',
//                             '4 times a day',
//                             '5 times a day',
//                             '6 times a day',
//                             'SOS',
//                             'STAT'
//                                 'Before Meal',
//                             'After Meal',
//                             'With Meal',
//                             'Empty Stomach'

enum Gender { Male, Female }

enum DoseUnit {
  mg,
  ml,
  gm,
  tablet,
  capsule,
  drops,
  sachet,
  teaspoon,
  puff,
  units
}

class Observation {
  String complaint;
  String since;
  ObservationDuration observationDuration;
  String? observation;
  String? diagnosis;
  Observation({
    required this.complaint,
    required this.since,
    required this.observationDuration,
    this.observation,
    this.diagnosis,
  });

  static List<ObservationDuration> getListofObservationDuration() {
    List<ObservationDuration> observationDurations = [];
    for (ObservationDuration observationDuration
        in ObservationDuration.values) {
      observationDurations.add(observationDuration);
    }
    return observationDurations;
  }

  Map<String, dynamic> toJson() {
    return {
      'complaint': complaint,
      'since': since,
      'observationDuration': observationDuration.index,
      'observation': observation,
      'diagnosis': diagnosis,
    };
  }
}

class Medicine {
  String name;
  int quantity;
  DoseUnit doseUnit;
  String when;
  String frequency;
  int forvalue;
  DurationUnit forUnit;
  String specialInstruction;
  String alternateMedicine;
  Medicine(
      {required this.name,//
      required this.quantity,//
      required this.doseUnit,//
      required this.when,//
      required this.frequency,//repeat
      required this.forvalue,//for 
      required this.forUnit,
      required this.specialInstruction,
      required this.alternateMedicine});

  // getQuantityUnitString() returns the string representation of the quantity unit
  static String getDoseUnitString(DoseUnit quantityUnit) {
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

  DoseUnit getDoseUnit(String value){
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

  String getQuantityString() {
    return '$quantity ${getDoseUnitString(doseUnit)}';
  }

  // getListofQuantityUnits() returns a list of strings of all the quantity units
  static List<DoseUnit> getListofQuantityUnits() {
    List<DoseUnit> quantityUnits = [];
    for (DoseUnit quantityUnit in DoseUnit.values) {
      quantityUnits.add(quantityUnit);
    }
    return quantityUnits;
  }

  static String getDurationString(DurationUnit durationUnit) {
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

  static String getWhenString(When when){
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


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'quantityUnit': doseUnit.toString().split('.').last,
      'when': when,
      'frequency': frequency,
      'duration': forvalue,
      'durationUnit': forUnit.toString().split('.').last,
      'specialInstruction': specialInstruction,
      'alternateMedicine': alternateMedicine,
    };
  }
}

class Complaint {
  String name;
  int since;
  DurationUnit unit;
  Complaint(this.name, this.since, this.unit);

  Map<String, dynamic> toJson() => {
        'name': name,
        'since': since,
        'unit': unit.toString().split('.').last,
      };

  static String getDurationString(DurationUnit durationUnit) {
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

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        json['name'],
        json['since'],
        DurationUnit.values.firstWhere(
            (unit) => unit.toString().split('.').last == json['unit']),
      );
}

class Hospital {
  String name;
  String address;
  String phone;
  Hospital(this.name, this.address, this.phone);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}

class Patient {
  int id;
  String name;
  int age;
  Gender gender;
  String mobileNo;
  DateTime? lastVisit;

  Patient(
      {required this.id,
      required this.name,
      required this.age,
      required this.gender,
      required this.mobileNo,
      this.lastVisit});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Patient && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  // generate a gender string from the enum

  String getGender() {
    String genderString;
    switch (gender) {
      case Gender.Male:
        genderString = 'Male';
        break;
      case Gender.Female:
        genderString = 'Female';
        break;
      default:
        genderString = 'Male';
    }
    return genderString;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'gender': getGender(),
        'mobileNo': mobileNo,
        'lastVisit': lastVisit?.toIso8601String(),
      };
}

class Doctor {
  String name;
  String specialization;
  List<Timings> timings;
  Doctor(this.name, this.specialization, this.timings);

  String getTimingsString() {
    Map<String, String> timingsMap = {};
    for (int i = 0; i < timings.length; i++) {
      String time = '${timings[i].startTime} - ${timings[i].endTime}';

      if (timingsMap[time] != null) {
        timingsMap[time] = '${timingsMap[time]}, ${timings[i].day}';
      } else {
        timingsMap[time] = timings[i].day;
      }
    }
    String timingsString = '';
    timingsMap.forEach((key, value) {
      timingsString += '$value: $key\n';
    });
    return timingsString;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specialization': specialization,
      'timings': timings
          .map((timing) => {
                'startTime': timing.startTime,
                'endTime': timing.endTime,
                'day': timing.day,
              })
          .toList(),
    };
  }

  String toJsonString() {
    return json.encode(toJson());
  }
}

// create a timings class for the doctor

class Timings {
  String day;
  String startTime;
  String endTime;

  Timings(this.day, this.startTime, this.endTime);
}

//create class for observation tab

class Investigation {
  String tests;
  String notes;
  Investigation(this.tests, this.notes);

  String getTestsString() {
    return '$tests';
  }

  String getNotesString() {
    return '$notes';
  }

  Map<String, dynamic> toJson() {
    return {
      'tests': tests,
      'notes': notes,
    };
  }

  String toJsonString() {
    return json.encode(toJson());
  }
}

class DietandAdvice {
  String diet;
  String advice;
  DietandAdvice(this.diet, this.advice);

  String getDietString() {
    return '$diet';
  }

  String getAdviceString() {
    return '$advice';
  }

  Map<String, dynamic> toJson() {
    return {
      'diet': diet,
      'advice': advice,
    };
  }
}
