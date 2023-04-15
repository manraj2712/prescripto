import 'package:flutter/material.dart';

import '../../model/patients.dart';

Container previewHeader({required Doctor doctor, required Hospital hospital}) {
  return Container(
    padding: const EdgeInsets.all(20),
    color: Colors.grey.shade100,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(hospital.name, style: PreviewHeaderFontStyles.heading1),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hospital.address,
            style: PreviewHeaderFontStyles.body,
          ),
          Text('Contact: ${hospital.phone}',
              style: PreviewHeaderFontStyles.body)
        ],
      ),
      const SizedBox(height: 20),
      Text(doctor.name, style: PreviewHeaderFontStyles.heading2),
      Text(
        doctor.specialization,
        style: PreviewHeaderFontStyles.body,
      ),
      const SizedBox(height: 10),
      Text.rich(TextSpan(
        text: 'Timings:',
        style: PreviewHeaderFontStyles.bodyBold,
        children: [
          TextSpan(
            text: ' ${doctor.getTimingsString()}',
            style: PreviewHeaderFontStyles.body,
          ),
        ],
      ))
    ]),
  );
}

class PreviewHeaderFontStyles {
  static const heading1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w700);
  static const heading2 = TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
  static const body = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(117, 117, 117, 1));
  static const bodyBold = TextStyle(fontSize: 12, fontWeight: FontWeight.w700);
}
