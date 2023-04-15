import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_prescription_frontend/constants/colors.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/patients/provider/patient_provider.dart';
import 'package:online_prescription_frontend/patients/provider/prescription_preview_provider.dart';
import 'package:online_prescription_frontend/patients/widgets/circleAvatar.dart';
import 'package:provider/provider.dart';

import '../model/patients.dart';
import '../widgets/Tabs/diet_and_advice_tab.dart';
import '../widgets/Tabs/investigation_tab.dart';
import '../widgets/Tabs/medication_tab.dart';
import '../widgets/Tabs/next_visit_tab.dart';
import '../widgets/Tabs/observation_tab.dart';
import '../widgets/preview_widgets/complaints.dart';
import '../widgets/preview_widgets/medicines.dart';
import '../widgets/preview_widgets/patient_details.dart';
import '../widgets/preview_widgets/preview_header.dart';
import 'prescription_screen.dart';

class PrescriptionPreview extends StatefulWidget {
  static const routeName = '/prescription-preview';
  @override
  _PrescriptionPreviewState createState() => _PrescriptionPreviewState();
}

class _PrescriptionPreviewState extends State<PrescriptionPreview>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late PrescriptionPreviewProvider prescriptionprovider;
  late PatientProvider patientprovider;
  late TabController tabController;
  List<Medicine> medicineList = [];

  final dietAndAdviceKey = GlobalKey<FormState>();
  // Define variables for holding the input values

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    // final provider =
    //     Provider.of<PrescriptionPreviewProvider>(context, listen: false);
    // provider.complaintController.dispose();
    // provider.sinceController.dispose();
    // provider.observationController.dispose();
    // provider.diagnosisController.dispose();
    // provider.testsController.dispose();
    // provider.notesController.dispose();
    // provider.medicineNameController.dispose();
    // provider.doseQuantityController.dispose();
    // provider.specialInstructionsController.dispose();
    // provider.alternateMedicineController.dispose();
    // provider.forController.dispose();
    // provider.addDietController.dispose();
    // provider.addAdviceController.dispose();
    // provider.nextVisitAfterController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    prescriptionprovider =
        Provider.of<PrescriptionPreviewProvider>(context, listen: false);
    patientprovider = Provider.of<PatientProvider>(context, listen: false);
    tabController = TabController(
        length: 5,
        vsync: this,
        animationDuration: Duration(milliseconds: 500),
        initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final prescriptionProvider =
    //     Provider.of<PrescriptionPreviewProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kulcare',
          style: MyFontStyles.heading1,
        ),
        backgroundColor: Colors.white,
      ),
      body: Row(children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatarWidget(
                  firstName: patientprovider.firstName,
                  lastName: patientprovider.lastName,
                ),
                title: Text(
                  patientprovider.firstName + " " + patientprovider.lastName,
                  style: MyFontStyles.heading1,
                ),
                subtitle: Text(
                    patientprovider.selectedGender.name + " / " +patientprovider.age.toString() + 'y'),
              ),
              Divider(),
              MyWidgets.verticalSeparator,
              MyWidgets.verticalSeparator,
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      'Date :',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  MyWidgets.horizontalSeparator,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: MyWidgets.borderRadius,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final _pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );
                        if (_pickedDate != null) {
                          prescriptionprovider.prescriptionDate = _pickedDate;
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          DateFormat('dd/MM/yy')
                              .format(prescriptionprovider.prescriptionDate),
                          style: MyFontStyles.heading2,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              MyWidgets.verticalSeparator,
              // Tab bar for selecting the input sections
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: MyColors.containerBgColor),
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: MyColors.primaryColor,
                  labelStyle: MyFontStyles.heading3,
                  labelColor: Colors.black,
                  controller: tabController,
                  labelPadding: EdgeInsets.symmetric(horizontal: 16),
                  tabs: [
                    Tab(
                      text: 'Observation',
                    ),
                    Tab(text: 'Investigation'),
                    Tab(text: 'Medication'),
                    Tab(text: 'Diet & Advice'),
                    Tab(text: 'Next visit'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    // Observation tab
                    ObservationTab(tabController, prescriptionprovider),
                    // Investigation tab
                    InvestigationTab(tabController, prescriptionprovider),

                    // Medication tab
                    MedicationTab(tabController, prescriptionprovider),

                    // Diet and Advice tab
                    DietandAdviceTab(tabController, prescriptionprovider),

                    //Next visit tab
                    NextVisitTab(prescriptionprovider, context)
                  ],
                ),
              ),

              // Prescription preview
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 2,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // contains data about the doctor and hospital to be displayed on the preview
            previewHeader(
                doctor: prescriptionprovider.doctor,
                hospital: prescriptionprovider.hospital),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  patientDetails(prescriptionprovider.patient),
                  const SizedBox(height: 10),
                  Divider(height: 0.5, color: Colors.grey.shade400),
                  const SizedBox(height: 20),

                  // complaints
                  if (prescriptionprovider.complaints.isNotEmpty)
                    complaintsColumn(prescriptionprovider.complaints),
                  if (medicineList.isNotEmpty) medicinesColumn(medicineList),
                  const SizedBox(height: 20),

                  // advice
                  const Text('Advice', style: PreviewFontStyles.heading2),
                  const SizedBox(height: 10),
                  Text(prescriptionprovider.getAdvice(),
                      style: PreviewFontStyles.body),
                  Divider(height: 0.5, color: Colors.grey.shade400),
                ],
              ),
            )
            // patient details and visit date
          ]),
        ),
      ]),
    );
  }

  Widget TheExpandedWidget() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Prescription Preview',
                style: MyFontStyles.heading1,
              ),
            ),
            MyWidgets.verticalSeparator,
            Container(
              color: MyColors.containerBgColor,
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          MyWidgets.verticalSeparator,
                          Text(
                            'Nephron Hospital',
                            style: MyFontStyles.heading2,
                          ),
                          MyWidgets.verticalSeparator,
                          Text(
                            'Moradabad, Uttar Pradesh, India',
                            style: MyFontStyles.heading3,
                          ),
                          MyWidgets.verticalSeparator,
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          MyWidgets.verticalSeparator,
                          Text(
                            'Raghav Chhabra',
                            style: MyFontStyles.heading2,
                          ),
                          Text(
                            'Nephrologist',
                            style: MyFontStyles.heading3,
                          ),
                          MyWidgets.verticalSeparator,
                        ],
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 8,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(TextSpan(
                      text: 'Pateint Details: ',
                      style: MyFontStyles.heading2,
                      children: [
                        TextSpan(
                            text: 'Manraj Singh, Male, 19y',
                            style: MyFontStyles.heading3)
                      ])),
                ),
                MyWidgets.horizontalSeparator,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(TextSpan(
                      text: 'Visit Date: ',
                      style: MyFontStyles.heading2,
                      children: [
                        TextSpan(
                            text: '24 Mar 2023', style: MyFontStyles.heading3)
                      ])),
                )
              ],
            ),
            Divider(),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(
                    'Complaints',
                    style: MyFontStyles.listTitleText,
                  ),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(TextSpan(
                          text:
                              Provider.of<PrescriptionPreviewProvider>(context)
                                  .observations
                                  .map((e) {
                                    return null;
                                    //TODO: return observations
                                  })
                                  .toString()
                                  .replaceAll(
                                      RegExp(r"\p{P}", unicode: true), ''),
                          style: MyFontStyles.ListSubtitleHead,
                          children: [TextSpan(text: ' - ')])),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownTextField extends StatefulWidget {
  final List<String> items;
  final String hint;
  final String value;
  final void Function(String) onChanged;

  const DropdownTextField({
    Key? key,
    required this.items,
    required this.hint,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DropdownTextFieldState createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedValue,
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value.toString();
          widget.onChanged(selectedValue);
        });
      },
    );
  }
}

class AddButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const AddButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add),
          SizedBox(width: 4),
          Text(text),
        ],
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

//Dropdown for forUnit
class ForDropDownField extends StatefulWidget {
  final String hint;
  final List<String> items;
  final void Function(String) onChanged;
  final String? selectedValue;
  final bool forUnit;

  const ForDropDownField({
    Key? key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    this.forUnit = false,
  }) : super(key: key);

  @override
  _ForDropDownFieldState createState() => _ForDropDownFieldState();
}

class _ForDropDownFieldState extends State<ForDropDownField> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue ?? widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value.toString();
          widget.onChanged(selectedValue);
        });
      },
    );
  }
}
