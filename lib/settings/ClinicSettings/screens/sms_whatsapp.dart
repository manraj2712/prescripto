import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_prescription_frontend/constants/colors.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class SmsWidget extends StatelessWidget {
  const SmsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final smsProvider = Provider.of<SettingProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyWidgets.verticalSeparator,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text.rich(TextSpan(
                  text:
                      "We send SMS and Whatsapp message to the patients at different point of time. You can turn the message off whenever you want.",
                  style: MyFontStyles.heading3)),
            ),
          ),
          MyWidgets.verticalSeparator,
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text.rich(TextSpan(
                  text: "Queue related SMS/Whatsapp",
                  style: MyFontStyles.heading2)),
            ),
          ),
          MyWidgets.verticalSeparator,
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text.rich(TextSpan(
                  text: "We send a SMS/Whatsapp:",
                  style: MyFontStyles.heading3)),
            ),
          ),
          _buildSwitch("When the patient is added to queue", context),
          _buildSwitch(
              "When the patient is checked out from the queue.", context),
          MyWidgets.verticalSeparator,
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text.rich(TextSpan(
                  text: "Appointment related SMS/Whatsapp",
                  style: MyFontStyles.heading2)),
            ),
          ),
          MyWidgets.verticalSeparator,
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text.rich(TextSpan(
                  text: "We send a SMS/Whatsapp:",
                  style: MyFontStyles.heading3)),
            ),
          ),
          MyWidgets.verticalSeparator,
          _buildSwitch("Appointment Confirmation", context),
          _buildSwitch("Appointment Cancellation", context),
          _buildSwitch("Appointment Reschedule", context),
          _buildSwitch("Appointment Reminder", context),
          Wrap(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              SizedBox(
                width: 60,
                child: TextField(
                  expands: false,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    smsProvider.updateValue(double.tryParse(newValue) ?? 0.0);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderRadius: MyWidgets.borderRadius,
                        borderSide: BorderSide(color: MyColors.containerColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: MyWidgets.borderRadius,
                        borderSide: BorderSide(color: MyColors.containerColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: MyWidgets.borderRadius,
                        borderSide: BorderSide(color: MyColors.primaryColor)),
                    hintText: "24",
                  ),
                ),
              ),
              MyWidgets.horizontalSeparator,
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: MyWidgets.borderRadius,
                  border: Border.all(color: MyColors.containerColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    value: smsProvider.unit,
                    isDense: true,
                    items: <String>['days', 'hours']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      smsProvider.updateUnit(newValue!);
                    },
                  ),
                ),
              ),
              MyWidgets.horizontalSeparator,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(TextSpan(
                    text: "Before Appointment", style: MyFontStyles.heading3)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Padding boldText(text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Text.rich(TextSpan(text: text, style: MyFontStyles.heading2)),
    );
  }

  Padding normalText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text.rich(TextSpan(text: text, style: MyFontStyles.heading3)),
    );
  }
}

Widget _buildSwitch(String text, BuildContext context) {
  final smsProvider = Provider.of<SettingProvider>(context);

  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.3,
    child: Wrap(
      spacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(text),
        ),
        Switch(
          value: smsProvider.isSwitched(text),
          onChanged: (bool value) {
            smsProvider.updateSwitch(text, value);
          },
        ),
      ],
    ),
  );
}
