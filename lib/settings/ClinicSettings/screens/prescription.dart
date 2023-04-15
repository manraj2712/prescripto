import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_prescription_frontend/constants/responsive.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class PrescriptionRow extends StatefulWidget {
  @override
  State<PrescriptionRow> createState() => _PrescriptionRowState();
}

class _PrescriptionRowState extends State<PrescriptionRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyWidgets.verticalSeparator,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "What do you want to print on the patient's prescription?",
            style:
                GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          children: [
            MyWidgets.verticalSeparator,
            _buildRow('Observations', context),
            _buildRow('Vitals', context),
            _buildRow('Medication', context),
            _buildRow('Investigation', context),
            _buildRow('Diet', context),
            _buildRow('Advice', context),
            _buildRow('Nextvisit', context),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(String text, BuildContext context) {
    final _prescriptionProvider = Provider.of<SettingProvider>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Checkbox(
          tristate: false,
          value: _prescriptionProvider.boolValue[text],
          onChanged: (value) {
            _prescriptionProvider.setChecked(text, value!);
          },
        ),
      ],
    );
  }
}
