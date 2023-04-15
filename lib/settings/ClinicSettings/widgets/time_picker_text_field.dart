import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/providers/setting_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TimePickerStartTextField extends StatelessWidget {
  String text;
  TimePickerStartTextField({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, timeModel, child) {
        return SizedBox(
          width: 200,
          height: 100,
          child: TextField(
            readOnly: true,
            controller: TextEditingController(
              text: timeModel.startTime.format(context),
            ),
            onTap: () async {
              final newTime = await showTimePicker(
                context: context,
                initialTime: timeModel.startTime,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child!,
                  );
                },
              );
              if (newTime != null) {
                timeModel.startTime = newTime;
              }
            },
            decoration: InputDecoration(
              labelText: text,
              suffixIcon: Icon(Icons.keyboard_arrow_down),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}
// ignore: must_be_immutable
class TimePickerEndTextField extends StatelessWidget {
  String text;
  TimePickerEndTextField({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, timeModel, child) {
        return SizedBox(
          width: 200,
          height: 100,
          child: TextField(
            readOnly: true,
            controller: TextEditingController(
              text: timeModel.endTime.format(context),
            ),
            onTap: () async {
              final newTime = await showTimePicker(
                context: context,
                initialTime: timeModel.endTime,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child!,
                  );
                },
              );
              if (newTime != null) {
                timeModel.endTime = newTime;
              }
            },
            decoration: InputDecoration(
              labelText: text,
              suffixIcon: Icon(Icons.keyboard_arrow_down),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}
