import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/patients/model/patients.dart';
import 'package:online_prescription_frontend/patients/provider/patient_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GenderRadioButtons extends StatelessWidget {
  const GenderRadioButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: MyFontStyles.heading2),
        Consumer<PatientProvider>(
          builder: (context, patientProvider, _) => Row(
            children: [
              Radio(
                value: Gender.Male,
                groupValue: patientProvider.selectedGender,
                onChanged: (value) {
                  patientProvider.updateSelectedGender(value as Gender);
                },
              ),
              Text('Male'),
              MyWidgets.horizontalSeparator,
              Radio(
                value: Gender.Female,
                groupValue: patientProvider.selectedGender,
                onChanged: (value) {
                  patientProvider.updateSelectedGender(value as Gender);
                },
              ),
              Text('Female'),
              MyWidgets.horizontalSeparator,
        if (patientProvider.selectedGender==null)
          Text('Please select a gender', style: MyFontStyles.errorText),
            ],
          ),
        ),
      ],
    );
  }
}
