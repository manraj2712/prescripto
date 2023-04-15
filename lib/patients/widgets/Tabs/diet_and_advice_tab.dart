import 'package:flutter/material.dart';

import '../../../constants/widgets.dart';
import '../../provider/prescription_preview_provider.dart';
import 'bullet_list_form.dart';

SingleChildScrollView DietandAdviceTab(TabController tabController,
    PrescriptionPreviewProvider prescriptionprovider) {
  final dietAndAdviceKey = GlobalKey<FormState>();
  final addDietController = TextEditingController(text: '•');
  final addAdviceController = TextEditingController(text: '•');
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Form(
      key: dietAndAdviceKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyWidgets.verticalSeparator,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  tabController.animateTo(4);
                },
                child: Text('Next >')),
          ),
          MyWidgets.verticalSeparator,
          // Add Diet field
          bulletListFormWithTextColumn(
              columnText: 'Add Diet', controller: addDietController),
          MyWidgets.verticalSeparator,
          MyWidgets.verticalSeparator,

          // Add Advice field
          bulletListFormWithTextColumn(
              columnText: 'Add Advice', controller: addAdviceController),
          MyWidgets.verticalSeparator,

          // Add button
          Container(
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                prescriptionprovider.addDiet = addDietController.text;
                prescriptionprovider.addAdvice = addAdviceController.text;
                addDietController.text = '•';
                addAdviceController.text = '•';
              },
              child: Text('Add'),
            ),
          ),

          MyWidgets.verticalSeparator,
          MyWidgets.verticalSeparator,
        ],
      ),
    ),
  );
}
