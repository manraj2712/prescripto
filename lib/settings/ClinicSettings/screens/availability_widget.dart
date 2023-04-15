import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/providers/setting_provider.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/widgets/dayselector.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/widgets/time_picker_text_field.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/widgets/unavailability_expansion_tile.dart';
import 'package:provider/provider.dart';

List<Map<String, String>> data = [];
Map<String, Map<String, dynamic>> uniqueMap = {};
List days = [
  'Daily',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thurday',
  'Friday',
  'Saturday',
  'Sunday'
];

class AvailabilityWidget extends StatefulWidget {
  const AvailabilityWidget({Key? key}) : super(key: key);

  @override
  State<AvailabilityWidget> createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyWidgets.verticalSeparator,
          MyWidgets.verticalSeparator,
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Select doctor and enter their availability",
                  style: MyFontStyles.heading2,
                ),
              ),
              dropDownTextField(context),
            ],
          ),
          MyWidgets.verticalSeparator,
          Container(
            constraints: BoxConstraints.tightFor(),
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: MyWidgets.borderRadius,
                border:
                    Border.all(color: Color.fromARGB(50, 0, 0, 0), width: 0.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyWidgets.verticalSeparator,
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Select Days",
                    style: MyFontStyles.heading2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: DaySelector(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Select times",
                    style: MyFontStyles.heading2,
                  ),
                ),
                Wrap(
                  children: [
                    MyWidgets.horizontalSeparator,
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TimePickerStartTextField(
                        text: 'Start Time',
                      ),
                    ),
                    MyWidgets.horizontalSeparator,
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: TimePickerEndTextField(
                          text: 'Close Time',
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    MyWidgets.horizontalSeparator,
                    ElevatedButton(
                        onPressed: () {
                          for (int i = 0; i < 8; i++) {
                            if (settingProvider.selectedDays[i] == true) {
                              data.add({
                                'day': days[i],
                                'time':
                                    "${(settingProvider.startTime.format(context))} - ${settingProvider.endTime.format(context)}"
                              });
                              setState(() {});
                              log(data.toString());
                            }
                          }
                        },
                        child: Text('Add')),
                    MyWidgets.horizontalSeparator,
                    MyWidgets.textButton(
                        text: 'Cancel',
                        onPressed: () {
                          settingProvider.selectedDays.map((e) => e = false);
                          settingProvider.startTime = TimeOfDay.now();
                          settingProvider.endTime = TimeOfDay.now();
                          setState(() {});
                        })
                  ],
                ),
                MyWidgets.verticalSeparator,
              ],
            ),
          ),
          MyWidgets.verticalSeparator,
          MyWidgets.verticalSeparator,
          if (data.isNotEmpty)
            ScheduleTable()
          else
            Center(
              child: Text('No timings available for the doctor yet'),
            ),
          MyWidgets.verticalSeparator,
          MyWidgets.verticalSeparator,
          UnavailablityExpansionTile(),
          MyWidgets.verticalSeparator,
        ],
      ),
    );
  }

  dropDownTextField(context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: MyWidgets.borderRadius,
          border: Border.all(color: Colors.grey.shade300, width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: const Icon(Icons.keyboard_arrow_down),
          borderRadius: MyWidgets.borderRadius,
          onChanged: (value) {},
          value: "Sarthak clinic",
          items: [
            DropdownMenuItem(
              value: "Sarthak clinic",
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Dr. Sarthak",
                  style: MyFontStyles.heading3,
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Vashu clinic",
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Vashu clinic",
                  style: MyFontStyles.heading3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // ),
  }
}

class ScheduleTable extends StatefulWidget {
  @override
  _ScheduleTableState createState() => _ScheduleTableState();
}

class _ScheduleTableState extends State<ScheduleTable> {
  @override
  Widget build(BuildContext context) {
    for (var item in data) {
      var key = item['day']! + item['time']!;
      uniqueMap[key] = item;
    }
    List<Map<String, dynamic>> uniqueList = uniqueMap.values.toList();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Table(
          columnWidths: {
            0: FractionColumnWidth(0.4),
            1: FractionColumnWidth(0.4),
            2: FractionColumnWidth(0.2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Day',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Timings',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            for (var item in uniqueList)
              TableRow(
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.grey[300]!))),
                children: [
                  TableCell(
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(color: Colors.grey[300]!))),
                        child: Text(item['day']!)),
                  ),
                  TableCell(
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(color: Colors.grey[300]!))),
                        child: Text(item['time']!)),
                  ),
                  TableCell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Implement edit action
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            data.removeWhere((element) =>
                                element['day'] == item['day'] &&
                                element['time'] == item['time']);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
