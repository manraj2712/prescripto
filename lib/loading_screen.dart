import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:online_prescription_frontend/database/database_config.dart';
import 'package:online_prescription_frontend/database/hospital_functions.dart';
import 'package:online_prescription_frontend/home_screen.dart';
import 'package:online_prescription_frontend/speciality_screen.dart';

enum LoadingState { waiting, loading, loaded, error }

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LoadingState loading = LoadingState.loading;
  bool hospitalDetailsExists = false;

  @override
  void initState() {
    try {
      DatabaseConfig.initializeDatabase().then((value) {
        DatabaseConfig.createTables().then((value) {
          HospitalModel.checkHospitalModelDetails().then((res) {
            if (res) {
              setState(() {
                loading = LoadingState.loaded;
                hospitalDetailsExists = true;
              });
            } else {
              setState(() {
                loading = LoadingState.loaded;
                hospitalDetailsExists = false;
              });
            }
          });
        });
      });
    } catch (e) {
      setState(() {
        loading = LoadingState.error;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: loading == LoadingState.loading
              ? const CircularProgressIndicator()
              : loading == LoadingState.loaded
                  ? hospitalDetailsExists
                      ? const HomeScreen()
                      : const SpecialityScreen()
                  : const SpecialityScreen()),
    );
  }
}
