import 'package:flutter/material.dart';

import '../../../constants/fonts_styles.dart';
import '../bullet_list_form_field.dart';

Column bulletListFormWithTextColumn({
  required String columnText,
  required TextEditingController controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        columnText,
        style: MyFontStyles.heading2,
      ),
      const SizedBox(height: 8),
      BulletListFormField(
        
        controller: controller,
      )
    ],
  );
}
