import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/constants/responsive.dart';
import 'package:online_prescription_frontend/patients/screens/patients_screen.dart';
import 'package:online_prescription_frontend/settings/ClinicProfile/screen/clinic_profile_screen.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/screens/clinic_setting_screen.dart';
import 'package:online_prescription_frontend/settings/Users/screens/UserScreen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Way2Go E-Prescription",
          style: MyFontStyles.heading1,
        ),
      ),
      body: Row(
        children: <Widget>[
          // Navigation Tabs
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  right: BorderSide(
                    width: 1.0,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  // Tab 1
                  Responsive.isDesktop(context)
                      ? ExpansionTile(
                          leading: FittedBox(child: const Icon(Icons.settings)),
                          title: const Text(
                            "Settings",
                            style: MyFontStyles.heading2,
                          ),
                          children: [
                            ListTile(
                              title: const Text(
                                "Clinic Settings",
                                style: MyFontStyles.heading3,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedTab = 0;
                                });
                              },
                            ),
                            ListTile(
                              title: const Text(
                                "Users",
                                style: MyFontStyles.heading3,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedTab = 1;
                                });
                              },
                              selected: _selectedTab == 1,
                            ),
                            ListTile(
                              title: const Text("Clinic Profile",
                                  style: MyFontStyles.heading3),
                              onTap: () {
                                setState(() {
                                  _selectedTab = 2;
                                });
                              },
                              selected: _selectedTab == 2,
                            ),
                          ],
                        )
                      : ExpansionTile(
                          title: Icon(Icons.settings),
                          children: [
                            ListTile(
                              title: const Text(
                                "Clinic Settings",
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedTab = 0;
                                });
                              },
                            ),
                            ListTile(
                              title: const Text("Users"),
                              onTap: () {
                                setState(() {
                                  _selectedTab = 1;
                                });
                              },
                              selected: _selectedTab == 1,
                            ),
                            ListTile(
                              title: const Text("Clinic Profile"),
                              onTap: () {
                                setState(() {
                                  _selectedTab = 2;
                                });
                              },
                              selected: _selectedTab == 2,
                            ),
                          ],
                        ),
                  ListTile(
                    leading: FittedBox(child: Icon(Icons.people)),
                    title: Text(
                      'Patients',
                      style: MyFontStyles.heading2,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedTab = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
// Tab Content
          Expanded(
            flex: 4,
            child: Container(
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return const ClinicSettingScreen();
      case 1:
        return const UserScreen();
      case 2:
        return const ClinicProfileScreen();
      case 3:
        return PatientScreen();
      // case 4:
      //   return const PatientsListScreen();
      // case 5:
      //   return const PrescriptionsListScreen();
      default:
        return const ClinicSettingScreen();
    }
  }
}
