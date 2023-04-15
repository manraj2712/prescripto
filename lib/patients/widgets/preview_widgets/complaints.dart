import 'package:flutter/material.dart';
import '../../model/patients.dart';
import '../../screens/prescription_screen.dart';

Column complaintsColumn(List<Complaint> complaints) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Complaints', style: PreviewFontStyles.heading2),
    const SizedBox(height: 10),
    Wrap(
      direction: Axis.horizontal,
      spacing: 5,
      children: complaints
          .map((complaint) => Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: complaint.name,
                      style: PreviewFontStyles.bodyBold.copyWith(
                          color: Colors.black87,
                          fontSize: 11,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text:
                          '- SINCE ${complaint.since} ${Medicine.getDurationString(complaint.unit)}',
                      style: PreviewFontStyles.body.copyWith(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    ),
    const SizedBox(height: 10),
    Divider(height: 0.5, color: Colors.grey.shade400),
  ]);
}
