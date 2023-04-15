import 'dart:html';

import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/home_screen.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_styles.dart';
import '../../../constants/widgets.dart';

Column prescriptionDropDownWidget(
      {required String columnText,
      required String value,
      required Function(String?)? onChanged,
      required List<String> items,
      required String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          columnText,
          style: MyFontStyles.heading2,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            constraints: BoxConstraints(
                    maxHeight: 40, minHeight: 40, minWidth: 100, maxWidth: 200)
                .normalize(),
            border: OutlineInputBorder(
              borderRadius: MyWidgets.borderRadius,
              borderSide: BorderSide(
                color: MyColors.containerColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: MyWidgets.borderRadius,
              borderSide: BorderSide(
                color: MyColors.primaryColor,
              ),
            ),
          ),
          value: value,
          onChanged: onChanged,
          onSaved: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: FittedBox(fit: BoxFit.scaleDown, child: Text(value)),
            );
          }).toList(),
        ),
      ],
    );
  }
