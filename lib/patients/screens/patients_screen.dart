import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_prescription_frontend/constants/colors.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/home_screen.dart';
import 'package:online_prescription_frontend/patients/provider/patient_provider.dart';
import 'package:online_prescription_frontend/patients/screens/prescription_preview_screen.dart';
import 'package:online_prescription_frontend/patients/widgets/datePickerRangeDialog.dart';
import 'package:online_prescription_frontend/patients/widgets/patientTable.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/screens/clinic_setting_screen.dart';
import 'package:provider/provider.dart';

import '../model/patients.dart';
import '../widgets/send_prescription_dialog.dart';

class PatientScreen extends StatefulWidget {
  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  // Define variables for dropdowns and date pickers
  String? _selectedDoctor;
  String? _selectedLocation;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  final searchPatientController = TextEditingController();
  late bool _idAscending;
  late bool _dateAscending;
  late String _sortColumn;
  late Patient newPatient;
  @override
  void initState() {
    // TODO: implement initState
    _idAscending = true;
    _dateAscending = true;
    _sortColumn = 'id';
    super.initState();
  }

  @override
  void dispose() {
    searchPatientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(15),
              height: 60,
              decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle add button press
                    },
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Handle menu item selection
                        switch (value) {
                          case 'Patient to queue':
                            // Handle patient to queue
                            break;
                          case 'New appointment':
                            // Handle new appointment
                            break;
                          case 'New patient':
                            // Handle new patient
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'Patient to queue',
                          child: Text('Patient to queue'),
                        ),
                        PopupMenuItem(
                          value: 'New appointment',
                          child: Text('New appointment'),
                        ),
                        PopupMenuItem(
                          value: 'New patient',
                          child: Text('New patient'),
                        ),
                      ],
                      child: Text('Add'),
                    ),
                  ),
                  MyWidgets.elevatedOutlineButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding:
                                    EdgeInsets.only(left: 50, right: 400),
                                title: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyWidgets.verticalSeparator,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Send Prescription',
                                            style: MyFontStyles.heading1,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            icon: Icon(Icons.close))
                                      ],
                                    ),
                                    Divider(
                                      height: 5,
                                    )
                                  ],
                                ),
                                content: SendPrescriptionDialog(),
                                actionsAlignment: MainAxisAlignment.start,
                                actions: [
                                  Action(provider, context),
                                ],
                              );
                            });
                      },
                      text: 'Send rx',
                      icon: Icon(Icons.note_add_outlined)),
                  MyWidgets.elevatedOutlineButton(
                    // () {}, "Availability", Icon(null)
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName)
                          .then((value) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ClinicSettingScreen();
                        }));
                      });
                    },
                    text: 'Availability',
                    icon: Icon(Icons.calendar_today_outlined),
                  ),
                ],
              ),
            ),
          ),
          MyWidgets.verticalSeparator,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                TextField(
                  decoration: InputDecoration(
                      constraints: BoxConstraints(
                        minHeight: 40,
                        maxHeight: 40,
                        minWidth: 150,
                        maxWidth: 160,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: MyWidgets.borderRadius,
                          borderSide:
                              BorderSide(color: MyColors.containerColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: MyWidgets.borderRadius,
                          borderSide:
                              BorderSide(color: MyColors.containerColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: MyWidgets.borderRadius,
                          borderSide: BorderSide(color: MyColors.primaryColor)),
                      hintText: 'Search patient',
                      hintStyle: TextStyle(fontSize: 14)),
                ),
                MyWidgets.horizontalSeparator,
                MyWidgets.textFieldContainer(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style: MyFontStyles.heading3,
                      value: _selectedDoctor,
                      hint: Text(
                        'All Doctors',
                        textAlign: TextAlign.center,
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text('Doctor 1'),
                          value: 'Doctor 1',
                        ),
                        DropdownMenuItem(
                          child: Text('Doctor 2'),
                          value: 'Doctor 2',
                        ),
                        DropdownMenuItem(
                          child: Text('Doctor 3'),
                          value: 'Doctor 3',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedDoctor = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16),
                MyWidgets.textFieldContainer(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style: MyFontStyles.heading3,
                      value: _selectedLocation,
                      hint: Text('All locations'),
                      items: [
                        DropdownMenuItem(
                          child: Text('Location 1'),
                          value: 'Location 1',
                        ),
                        DropdownMenuItem(
                          child: Text('Location 2'),
                          value: 'Location 2',
                        ),
                        DropdownMenuItem(
                          child: Text('Location 3'),
                          value: 'Location 3',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedLocation = value;
                        });
                      },
                    ),
                  ),
                ),
                MyWidgets.horizontalSeparator,
                customDateRangePicker(context),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Handle upload button press
                  },
                  child: Text('Upload Patients'),
                ),
                SizedBox(width: 16),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.vertical_align_top),
                    tooltip: 'Export Data'),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: PatientTable(),
          ),
        ],
      ),
    );
  }

  GestureDetector customDateRangePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDialog(
            context: context,
            builder: (context) {
              return DateRangePickerWidget(onSelected: (startDate, endDate) {
                setState(() {
                  _startDate = startDate;
                  _endDate = endDate;
                });
              });
            });
        if (picked != null
            // && picked != DateTimeRange.empty()
            ) {
          setState(() {
            _startDate = picked.start;
            _endDate = picked;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        constraints: BoxConstraints(
          minHeight: 40,
          maxHeight: 40,
          minWidth: 150,
          maxWidth: 160,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.containerColor),
          borderRadius: MyWidgets.borderRadius,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today,
            ),
            SizedBox(width: 8),
            Text(
              '${DateFormat('dd MMM').format(_startDate)}',
              style: MyFontStyles.heading3,
            ),
            Text(' - '),
            Text(
              "${DateFormat('dd MMM').format(_endDate)}",
              style: MyFontStyles.heading3,
            )
          ],
        ),
      ),
    );
  }

  AlertDialog sendPrescriptionAlertDialog(
      BuildContext context, PatientProvider provider) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 50, right: 400),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyWidgets.verticalSeparator,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Send Prescription',
                  style: MyFontStyles.heading1,
                ),
              ),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close))
            ],
          ),
          Divider(
            height: 5,
          )
        ],
      ),
      content: SendPrescriptionDialog(),
      actionsAlignment: MainAxisAlignment.start,
      actions: [
        Action(provider, context),
      ],
    );
  }

  Action(PatientProvider provider, BuildContext context) {
    return Container(
      color: MyColors.containerBgColor,
      width: double.infinity,
      height: 70,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          MyWidgets.horizontalSeparator,
          MyWidgets.horizontalSeparator,
          MyWidgets.horizontalSeparator,
          ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15))),
              onPressed: () {
                SendPrescriptionDialog dialog = SendPrescriptionDialog();
                FormState? sendPrescriptionKeyState =
                    dialog.getSendPrescriptionKeyState();

                if (sendPrescriptionKeyState != null) {
                  sendPrescriptionKeyState.save();
                  sendPrescriptionKeyState.validate();
                }
                newPatient = Patient(
                    age: provider.age,
                    id: DateTime.now().microsecondsSinceEpoch,
                    name: provider.firstName + " " + provider.lastName,
                    gender: provider.selectedGender,
                    mobileNo: provider.mobileNo,
                    lastVisit: DateTime.now());
                if (!provider.patients
                    .any((patient) => patient.id == newPatient.id)) {
                  provider.addPatient(newPatient);
                }
                //  sendPrescriptionKey.currentState!.validate();
                // sendPrescriptionKey.currentState!.save();
                Navigator.of(context).pushNamed(PrescriptionPreview.routeName);
              },
              child: Text('Continue')),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
