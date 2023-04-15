import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class DatabaseConfig {
  static Database? _db;

  // create getter for _db
  static get database {
    return _db;
  }

  static Future<void> initializeDatabase() async {
    try {
      sqfliteFfiInit();
      _db = await databaseFactoryFfi.openDatabase('e_prescription.db');
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> createTables() async {
    // create a hospital details table in the database if it does not exist

    await _db!.execute("CREATE TABLE IF NOT EXISTS hospital_details ("
        "id INTEGER AUTO_INCREMENT PRIMARY KEY,"
        "name TEXT,"
        "address TEXT,"
        "phoneNumber TEXT,"
        "speciality TEXT,"
        "email TEXT"
        ")");

    // limit the number of rows to 1
    await _db!.execute("CREATE TRIGGER IF NOT EXISTS hospital_details_trigger "
        "BEFORE INSERT ON hospital_details "
        "WHEN (SELECT COUNT(*) FROM hospital_details) >= 1 "
        "BEGIN "
        "DELETE FROM hospital_details; "
        "END");

    // create a patients table in the database if it does not exist

    await _db!.execute("CREATE TABLE IF NOT EXISTS patients ("
        "id INTEGER AUTO_INCREMENT PRIMARY KEY,"
        "phoneNumber varchar(10) NOT NULL UNIQUE,"
        "name varchar(50),"
        "age INTEGER,"
        "gender char(1)"
        ")");

    await _db!.execute("CREATE TABLE IF NOT EXISTS doctors ("
        "id INTEGER AUTO_INCREMENT PRIMARY KEY,"
        "name varchar(50),"
        "specialization TEXT,"
        "qualification TEXT"
        ")");

    // create medicines table in the database if it does not exist with salts column as List<Map<String, dynamic>>

    await _db!.execute("CREATE TABLE IF NOT EXISTS medicines ("
        "id INTEGER AUTO_INCREMENT PRIMARY KEY,"
        "name TEXT,"
        "salts TEXT,"
        "description TEXT,"
        "type TEXT"
        ")");

    // reference doctor from doctor table using doctorId
    await _db!.execute("CREATE TABLE IF NOT EXISTS prescriptions ("
        "id INTEGER AUTO_INCREMENT PRIMARY KEY,"
        "patientPhoneNumber TEXT,"
        "patientName TEXT,"
        "doctorId INTEGER,"
        "date DATE,"
        "diagnosis TEXT,"
        "advice TEXT,"
        "medicines TEXT,"
        "FOREIGN KEY (doctorId) REFERENCES doctors(id)"
        ")");

    return;
  }
}
