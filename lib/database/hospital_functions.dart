import 'package:online_prescription_frontend/database/database_config.dart';

class HospitalModel {
  String name;
  String speciality;
  String address;
  String phoneNumber;
  String email;

  HospitalModel(
      {required this.name,
      required this.speciality,
      required this.address,
      required this.phoneNumber,
      required this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['speciality'] = speciality;
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;

    return data;
  }

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      name: json['name'],
      speciality: json['speciality'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }

  // insert HospitalModel details into database
  static Future<void> addHospitalModel(HospitalModel HospitalModel) async {
    try {
      final db = DatabaseConfig.database;
      await db.insert('HospitalModel_details', HospitalModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  // create a static method which returns bool if HospitalModel details are present in database
  static Future<bool> checkHospitalModelDetails() async {
    try {
      final db = DatabaseConfig.database;
      final List<Map<String, dynamic>> HospitalModelDetails =
          await db.query('HospitalModel_details');
      if (HospitalModelDetails.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
