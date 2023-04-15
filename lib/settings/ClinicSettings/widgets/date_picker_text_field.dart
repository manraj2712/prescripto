import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class DatePickerTextField extends StatelessWidget {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final String text;

  DatePickerTextField({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<SettingProvider>(context);

    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: dateProvider.selectedDate ?? DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2101),
        );
        if (picked != null) {
          dateProvider.selectDate(picked);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: text,
            prefixIcon: Icon(Icons.calendar_today),
          ),
          initialValue: dateProvider.selectedDate != null
              ? _dateFormat.format(dateProvider.selectedDate!)
              : null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a date';
            }
            return null;
          },
          onSaved: (value) {
            final date = _dateFormat.parse(value!);
            debugPrintSynchronously(date.toString());
            //TODO: Save the date somewhere
          },
        ),
      ),
    );
  }
}
