import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../patients/widgets/bullet_list_form_field.dart';
import '../settings/ClinicSettings/providers/setting_provider.dart';
import 'colors.dart';
import 'fonts_styles.dart';

abstract class MyWidgets {
  // call to action button
  static ctaButton({required String text, required Function onPressed}) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Text(text),
      style: ButtonStyle(
        alignment: Alignment.center,
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 45)),
      ),
    );
  }

  static textButton({required String text, required Function onPressed}) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(text));
  }

  static const verticalSeparator = SizedBox(height: 15);

  static const horizontalSeparator = SizedBox(width: 15);

  static final borderRadius = BorderRadius.circular(2);

  static showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  static tableBorder() {
    return TableBorder(
        horizontalInside: const BorderSide(color: Colors.blueGrey, width: 0.3),
        verticalInside: const BorderSide(color: Colors.blueGrey, width: 0.3),
        bottom: const BorderSide(width: 0.3, color: Colors.blueGrey),
        top: const BorderSide(width: 0.3, color: Colors.blueGrey));
  }

  TextField tableTextField(
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted,
      SettingProvider provider) {
    return TextField(
      controller: textEditingController,
      focusNode: focusNode,
      onEditingComplete: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: "Type & select OR press enter to add",
        hintStyle: GoogleFonts.ubuntu(),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onSubmitted: (value) {
        textEditingController.clear();
        provider.vitalsController.text = value;
        provider.addRecord(provider.vitalsController.text);
      },
    );
  }

  static serviceTextField(
      TextEditingController textEditingController, String label) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: label,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );
  }

  static elevatedOutlineButton(
      {required VoidCallback onPressed, text, required Icon icon}) {
    return Material(
      elevation: 8.0,
      borderRadius: MyWidgets.borderRadius,
      child: OutlinedButton(
        onPressed: onPressed,
        child:
            Row(mainAxisSize: MainAxisSize.min, children: [icon, Text(text)]),
      ),
    );
  }

  static textFieldContainer({required Widget child}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 40,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: MyWidgets.borderRadius,
            border: Border.all(color: Colors.grey.shade300, width: 1)),
        child: child);
  }

  static textFieldBelowColumn({
    required String columnText,
    required String labelText,
    required void Function(String?)? onsaved,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          columnText,
          style: MyFontStyles.heading2,
        ),
        const SizedBox(height: 8),
        TextFormField(
            validator: validator,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10, bottom: 5),
              constraints: BoxConstraints(
                maxHeight: 40,
                minHeight: 30,
              ),
              border: OutlineInputBorder(
                borderRadius: MyWidgets.borderRadius,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: MyWidgets.borderRadius,
                borderSide: BorderSide(
                  color: MyColors.primaryColor,
                ),
              ),
            ),
            onSaved: onsaved),
      ],
    );
  }

  static bulletListFormWithTextColumn(
      {required String columnText,
      required TextEditingController controller,}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          columnText,
          style: MyFontStyles.heading2,
        ),
        const SizedBox(height: 8),
        BulletListFormField(controller: controller)
      ],
    );
  }

  static EdgeInsets contentpadding() => EdgeInsets.only(bottom: 5, left: 5);
}
