import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';

import 'date_picker_text_field.dart';
import 'time_picker_text_field.dart';

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
            style:
                GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.bold),
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
              Text(
                "I am unavailable from",
                style: GoogleFonts.openSans(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 6.5,
              ),
              Text(
                "I am unavailable till",
                style: GoogleFonts.openSans(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
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

  SizedBox dropDownTextField(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.3,
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: MyWidgets.borderRadius),
          enabledBorder:
              OutlineInputBorder(borderRadius: MyWidgets.borderRadius),
          focusedBorder:
              OutlineInputBorder(borderRadius: MyWidgets.borderRadius),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            onChanged: (value) {},
            value: "Sarthak clinic",
            items: [
              DropdownMenuItem(
                value: "Sarthak clinic",
                child: Text("Sarthak clinic"),
              ),
              DropdownMenuItem(
                value: "Vashu clinic",
                child: Text("Vashu clinic"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
