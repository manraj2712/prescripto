import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/patients.dart';
import '../../screens/prescription_screen.dart';

Row patientDetails(Patient patient) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text.rich(
        TextSpan(
          text: 'Patient Details : ',
          style: PreviewFontStyles.heading2,
          children: [
            TextSpan(
              text: patient.name,
              style: PreviewFontStyles.body,
            ),
            TextSpan(
              text: ', ${patient.age}',
              style: PreviewFontStyles.body,
            ),
            TextSpan(
              text: ', ${patient.getGender()}',
              style: PreviewFontStyles.body,
            ),
          ],
        ),
      ),
      Text.rich(
        TextSpan(
          text: 'Visit Date : ',
          style: PreviewFontStyles.heading2,
          children: [
            TextSpan(
              text: DateFormat('dd MMM yyyy').format(DateTime.now()),
              style: PreviewFontStyles.body,
            ),
          ],
        ),
      ),
    ],
  );
}
