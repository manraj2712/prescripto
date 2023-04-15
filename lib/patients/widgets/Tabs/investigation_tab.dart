import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_styles.dart';
import '../../../constants/widgets.dart';
import '../../provider/prescription_preview_provider.dart';

///Investigation Tab
Padding InvestigationTab(TabController tabController,
    PrescriptionPreviewProvider prescriptionprovider) {
  final testsController = TextEditingController();
  final notesController = TextEditingController();
  int editIndexInvest = -1;
  final investigationKey = GlobalKey<FormState>();
  return Padding(
    padding: const EdgeInsets.only(left: 30.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyWidgets.verticalSeparator,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  tabController.animateTo(2);
                },
                child: Text('Next >')),
          ),
          MyWidgets.verticalSeparator,
          // Select Tests field
          Form(
            key: investigationKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: MyWidgets.textFieldBelowColumn(
                        columnText: 'Select Tests',
                        labelText: 'Select Tests',
                        controller: testsController,
                        onsaved: (value) {
                          prescriptionprovider.tests = value!;
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter tests';
                          }
                          return null;
                        })),
                MyWidgets.horizontalSeparator,
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: MyWidgets.bulletListFormWithTextColumn(
                            columnText: 'Notes',
                            controller: notesController))),
                MyWidgets.horizontalSeparator,
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(top: 28),
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () {
                        if (prescriptionprovider.editModeInvest) {
                          if (investigationKey.currentState!.validate()) {
                            prescriptionprovider.updateInvestigation(
                                testsController.text,
                                notesController.text,
                                editIndexInvest);
                            investigationKey.currentState!.save();
                            testsController.clear();
                            notesController.text = '•';
                          }
                        } else {
                          prescriptionprovider.addInvestigation(
                              testsController.text, notesController.text);
                          testsController.clear();
                          notesController.text = '•';
                        }
                      },
                      child: Consumer<PrescriptionPreviewProvider>(
                        builder: (context, value, child) {
                          return Text(value.editModeInvest ? 'Update' : 'Add');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          MyWidgets.verticalSeparator,
          //container to show investigation value
          Consumer<PrescriptionPreviewProvider>(
            builder: (context, values, child) {
              return Wrap(
                children: values.investigations.map((item) {
                  int investigationIndex = values.investigations.indexOf(item);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.containerColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // item['tests']!,
                                  item.tests,
                                  style: MyFontStyles.heading2,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  // item['notes']!
                                  item.notes,
                                ),
                              ],
                            ),
                          ),
                          prescriptionprovider.editModeInvest
                              ? IconButton(
                                  onPressed: () {
                                    editIndexInvest = investigationIndex;
                                    values.updateInvestigation(
                                        testsController.text,
                                        notesController.text,
                                        editIndexInvest);
                                    testsController.clear();
                                    notesController.text = '•';
                                    prescriptionprovider
                                        .seteditModeInvest(false);
                                  },
                                  icon: investigationIndex == editIndexInvest
                                      ? Icon(
                                          Icons.check,
                                          color: MyColors.iconColor,
                                        )
                                      : Icon(
                                          Icons.edit_outlined,
                                          color: MyColors.iconColor,
                                        ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    editIndexInvest = investigationIndex;
                                    testsController.text = item.tests;
                                    // item['tests']!;
                                    notesController.text =
                                        // item['notes']!;
                                        item.notes;
                                    prescriptionprovider
                                        .seteditModeInvest(true);
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: MyColors.iconColor,
                                  ),
                                ),
                          IconButton(
                            onPressed: () {
                              // values.removeInvestigation(investigationIndex);
                              values.deleteInvestigation(investigationIndex);
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: MyColors.iconColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    ),
  );
}
