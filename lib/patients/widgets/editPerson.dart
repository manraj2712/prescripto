import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_prescription_frontend/patients/provider/patient_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/fonts_styles.dart';
import '../../constants/widgets.dart';
import '../model/patients.dart';

class EditPersonDialog extends StatelessWidget {
  final Patient person;
  final editPatientKey = GlobalKey<FormState>();

  EditPersonDialog({required this.person});

  @override
  Widget build(BuildContext context) {
    final patientProvider =
        Provider.of<PatientProvider>(context, listen: false);
    return AlertDialog(
      title: Text('Edit Patient'),
      content: SingleChildScrollView(
        child: Form(
          key: editPatientKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 40),
                  border: OutlineInputBorder(
                      borderRadius: MyWidgets.borderRadius,
                      borderSide: BorderSide(color: MyColors.containerColor)),
                  focusColor: MyColors.primaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.primaryColor),
                    borderRadius: MyWidgets.borderRadius,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.primaryColor),
                    borderRadius: MyWidgets.borderRadius,
                  ),
                  labelText: 'Name',
                  hintText: 'Enter name',
                ),
                controller: TextEditingController(text: person.name),
                onSaved: (value) => person.name = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Name cannot be empty' : null,
              ),
              MyWidgets.verticalSeparator,
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: MyWidgets.borderRadius,
                      borderSide: BorderSide(color: MyColors.containerColor)),
                  focusColor: MyColors.primaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.primaryColor),
                    borderRadius: MyWidgets.borderRadius,
                  ),
                  constraints: BoxConstraints(maxHeight: 40),
                  labelText: 'Age',
                  hintText: 'Enter age',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Age cannot be empty' : null,
                controller: TextEditingController(text: person.age.toString()),
                keyboardType: TextInputType.number,
                onSaved: (value) => person.age = int.parse(value!),
              ),
              MyWidgets.verticalSeparator,
              TextFormField(
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 40),
                  border: OutlineInputBorder(
                      borderRadius: MyWidgets.borderRadius,
                      borderSide: BorderSide(color: MyColors.containerColor)),
                  focusColor: MyColors.primaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.primaryColor),
                    borderRadius: MyWidgets.borderRadius,
                  ),
                  labelText: 'Gender',
                  hintText: 'Enter gender',
                ),
                controller: TextEditingController(text: person.gender.name),
                onSaved: (value) => person.gender = value as Gender,
              ),
              MyWidgets.verticalSeparator,
              TextFormField(
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 40),
                  border: OutlineInputBorder(
                      borderRadius: MyWidgets.borderRadius,
                      borderSide: BorderSide(color: MyColors.containerColor)),
                  focusColor: MyColors.primaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.primaryColor),
                    borderRadius: MyWidgets.borderRadius,
                  ),
                  labelText: 'Mobile No.',
                  hintText: 'Enter mobile number',
                ),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: person.mobileNo),
                onSaved: (value) => person.mobileNo = value!,
              ),
              MyWidgets.verticalSeparator,
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000));
                  final selectedDate = await date;
                  if (selectedDate != null) {
                    person.lastVisit = selectedDate;
                  }
                },
                child: MyWidgets.textFieldContainer(
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${DateFormat('dd MMM yy').format(person.lastVisit as DateTime)}',
                        style: MyFontStyles.heading3,
                      ),
                    ],
                  ),
                ),
              ),
              MyWidgets.verticalSeparator,
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            editPatientKey.currentState!.validate();
            editPatientKey.currentState!.save();
            patientProvider.sortList(patientProvider.patients);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

// void editPerson(Patient person, BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Edit Patient'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(
//                   constraints: BoxConstraints(maxHeight: 40),
//                   border: OutlineInputBorder(
//                       borderRadius: MyWidgets.borderRadius,
//                       borderSide: BorderSide(color: MyColors.containerColor)),
//                   focusColor: MyColors.primaryColor,
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: MyColors.primaryColor),
//                     borderRadius: MyWidgets.borderRadius,
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: MyColors.primaryColor),
//                     borderRadius: MyWidgets.borderRadius,
//                   ),
//                   labelText: 'Name',
//                   hintText: 'Enter name',
//                 ),
//                 controller: TextEditingController(text: person.name),
//                 onChanged: (value) => person.name = value,
//               ),
//               MyWidgets.verticalSeparator,
//               TextFormField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: MyWidgets.borderRadius,
//                       borderSide: BorderSide(color: MyColors.containerColor)),
//                   focusColor: MyColors.primaryColor,
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: MyColors.primaryColor),
//                     borderRadius: MyWidgets.borderRadius,
//                   ),
//                   constraints: BoxConstraints(maxHeight: 40),
//                   labelText: 'Age',
//                   hintText: 'Enter age',
//                 ),
//                 controller: TextEditingController(text: person.age.toString()),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) => person.age = int.parse(value),
//               ),
//               MyWidgets.verticalSeparator,
//               TextFormField(
//                 decoration: InputDecoration(
//                   constraints: BoxConstraints(maxHeight: 40),
//                   border: OutlineInputBorder(
//                       borderRadius: MyWidgets.borderRadius,
//                       borderSide: BorderSide(color: MyColors.containerColor)),
//                   focusColor: MyColors.primaryColor,
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: MyColors.primaryColor),
//                     borderRadius: MyWidgets.borderRadius,
//                   ),
//                   labelText: 'Gender',
//                   hintText: 'Enter gender',
//                 ),
//                 controller: TextEditingController(text: person.gender),
//                 onChanged: (value) => person.gender = value,
//               ),
//               MyWidgets.verticalSeparator,
//               TextFormField(
//                 decoration: InputDecoration(
//                   constraints: BoxConstraints(maxHeight: 40),
//                   border: OutlineInputBorder(
//                       borderRadius: MyWidgets.borderRadius,
//                       borderSide: BorderSide(color: MyColors.containerColor)),
//                   focusColor: MyColors.primaryColor,
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: MyColors.primaryColor),
//                     borderRadius: MyWidgets.borderRadius,
//                   ),
//                   labelText: 'Mobile No.',
//                   hintText: 'Enter mobile number',
//                 ),
//                 controller: TextEditingController(text: person.mobileNo),
//                 onChanged: (value) => person.mobileNo = value,
//               ),
//               MyWidgets.verticalSeparator,
//               GestureDetector(
//                 onTap: () async {
//                   final date = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(3000));
//                   final selectedDate = await date;
//                   if (selectedDate != null) {
//                     person.lastVisit = selectedDate;
//                   }
//                 },
//                 child: MyWidgets.textFieldContainer(
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.calendar_today,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         '${DateFormat('dd MMM yy').format(person.lastVisit as DateTime)}',
//                         style: MyFontStyles.heading3,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               MyWidgets.verticalSeparator,
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               sortList(patients);
//               // patients.add(person);
//               notifyListeners();
//               Navigator.of(context).pop();
//             },
//             child: Text('Save'),
//           ),
//         ],
//       );
//     },
//   );
//   notifyListeners();
// }
