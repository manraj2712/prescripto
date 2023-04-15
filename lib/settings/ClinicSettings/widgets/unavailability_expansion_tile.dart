import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/constants/colors.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';

import '../../../constants/widgets.dart';
import 'date_picker_text_field.dart';
import 'time_picker_text_field.dart';

class UnavailablityExpansionTile extends StatefulWidget {
  @override
  State<UnavailablityExpansionTile> createState() =>
      _UnavailabilityExpansionTileState();
}

class _UnavailabilityExpansionTileState
    extends State<UnavailablityExpansionTile> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        collapsedBackgroundColor: MyColors.containerColor,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
        leading: _isExpanded ? Icon(Icons.remove_sharp) : Icon(Icons.add_sharp),
        title: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            "Set Unavailability",
            style: MyFontStyles.heading2,
          ),
        ),
        trailing: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            "Set your unavailable hours when people can't schedule meeting with you",
            style: MyFontStyles.heading3,
          ),
        ),
        children: [DisappearingWidget()]);
  }
}

class DisappearingWidget extends StatelessWidget {
  const DisappearingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyWidgets.verticalSeparator,
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            "Select Doctor",
            style: MyFontStyles.heading2,
          ),
        ),
        MyWidgets.verticalSeparator,
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: dropDownTextField(context),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 20, top: 20),
              child: Text("I am unavailable till further notice"),
            ),
            MyWidgets.verticalSeparator,
            MyWidgets.verticalSeparator,
            MyWidgets.verticalSeparator,
            Switch.adaptive(value: false, onChanged: (value) {})
          ],
        ),
        MyWidgets.verticalSeparator,
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Text("I am unavailable from", style: MyFontStyles.heading2),
              SizedBox(
                width: MediaQuery.of(context).size.width / 6.5,
              ),
              Text("I am unavailable till", style: MyFontStyles.heading2),
            ],
          ),
        ),
        MyWidgets.verticalSeparator,
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.8,
          height: MediaQuery.of(context).size.height / 15,
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: DatePickerTextField(
                    text: "Start Date",
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(child: TimePickerStartTextField(text: "Start Time")),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: DatePickerTextField(
                    text: "End Date",
                  ),
                ),
              ),
              MyWidgets.horizontalSeparator,
              Flexible(child: TimePickerEndTextField(text: "End Time")),
            ],
          ),
        ),
        MyWidgets.verticalSeparator
      ],
    );
  }

  dropDownTextField(context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: MyWidgets.borderRadius,
          border: Border.all(color: MyColors.containerColor, width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          onChanged: (value) {},
          value: "Sarthak clinic",
          items: [
            DropdownMenuItem(
              value: "Sarthak clinic",
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Sarthak clinic"),
              ),
            ),
            DropdownMenuItem(
              value: "Vashu clinic",
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Vashu clinic"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
