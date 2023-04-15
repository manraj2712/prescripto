import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/database/database_config.dart';
import 'package:online_prescription_frontend/database/hospital_functions.dart';
import 'package:online_prescription_frontend/loading_screen.dart';
import 'package:online_prescription_frontend/patients/model/patients.dart';
import 'package:online_prescription_frontend/patients/provider/patient_provider.dart';
import 'package:online_prescription_frontend/patients/provider/prescription_preview_provider.dart';
import 'package:online_prescription_frontend/settings/ClinicProfile/provider/clinic_profile_provider.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/models/prescription.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/providers/setting_provider.dart';
import 'package:online_prescription_frontend/home_screen.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/screens/clinic_setting_screen.dart';
import 'package:online_prescription_frontend/settings/Users/provider/user_provider.dart';
import 'package:online_prescription_frontend/speciality_screen.dart';
import 'package:provider/provider.dart';

import 'package:online_prescription_frontend/login/providers/login_signup_provider.dart';

import 'login/screens/login_signup_screen.dart';
import 'patients/screens/prescription_preview_screen.dart';
import 'patients/screens/prescription_screen.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginSignUpProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ClinicProfileProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => PrescriptionPreviewProvider()),
      ],
      child: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Muli",
        platform: TargetPlatform.windows,
      ),
      debugShowCheckedModeBanner: false,
      title: "Kulcare",
      routes: {
        '/': (context) => LoadingScreen(),
        // '/': (context) => PreviewScreen(),
        // '/': (context) => SpecialityScreen(),
        // '/': (context) => PrescriptionPreview(),
        HomeScreen.routeName: (context) => HomeScreen(),
        PrescriptionPreview.routeName: (context) => PrescriptionPreview(),
        ClinicSettingScreen.routeName: (context) => ClinicSettingScreen(),
      },
    );
  }
}
