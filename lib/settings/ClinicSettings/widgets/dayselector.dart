import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class DaySelector extends StatefulWidget {
  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  @override
  Widget build(BuildContext context) {
    final daySelectorProvider = Provider.of<SettingProvider>(context);
    return Row(
      children: [
        for (var i = 0; i < 8; i++)
          GestureDetector(
            onTap: () {
              daySelectorProvider.toggleDay(i);
            },
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints.tightFor(),
              decoration: BoxDecoration(
                color: daySelectorProvider.selectedDays[i]
                    ? Colors.purple
                    : Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ['Daily', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i],
                  style: TextStyle(
                    color: daySelectorProvider.selectedDays[i]
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        // ),
      ],
    );
  }
}
