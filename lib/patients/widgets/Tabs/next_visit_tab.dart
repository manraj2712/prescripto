import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_prescription_frontend/patients/widgets/Tabs/prescription_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../constants/fonts_styles.dart';
import '../../../constants/widgets.dart';
import '../../provider/prescription_preview_provider.dart';

NextVisitTab(
      PrescriptionPreviewProvider prescriptionprovider, BuildContext context) {
        final nextVisitKey = GlobalKey<FormState>();
    final nextVisitAfterController=TextEditingController();
    return Form(
      key: nextVisitKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyWidgets.verticalSeparator,
          MyWidgets.verticalSeparator,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyWidgets.horizontalSeparator,
              SizedBox(
                width: 200,
                child: MyWidgets.textFieldBelowColumn(
                    columnText: 'Next visit After',
                    labelText: 'Next visit',
                    onsaved: (value) {
                      prescriptionprovider.nextVisitAfter = value!;
                      // if (prescriptionprovider.Frequency == 'Days')
                      //   prescriptionprovider.setNextVisitDate(
                      //       prescriptionprovider.nextVisitDate
                      //           .add(Duration(days: int.parse(value))));
                      // else if (prescriptionprovider.Frequency == 'Weeks')
                      //   prescriptionprovider.setNextVisitDate(
                      //       prescriptionprovider.nextVisitDate
                      //           .add(Duration(days: int.parse(value) * 7)));
                      // else if (prescriptionprovider.Frequency == 'Months')
                      //   prescriptionprovider.setNextVisitDate(
                      //       prescriptionprovider.nextVisitDate
                      //           .add(Duration(days: int.parse(value) * 30)));
                    },
                    controller: nextVisitAfterController,
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Please enter a value';
                      if (int.parse(value) < 1)
                        return 'Please enter a valid value';
                      return null;
                    }),
              ),
              MyWidgets.horizontalSeparator,
              Flexible(
                  key: nextVisitKey,
                  child: prescriptionDropDownWidget(
                    columnText: 'Frequency',
                    value: 'Days',
                    onChanged: (value) {
                      frequency = value.toString();
                    },
                    items: <String>['Days', 'Weeks', 'Months'],
                    hintText: 'Unit',
                  )),
              MyWidgets.horizontalSeparator,
              Column(
                children: [Text(''), MyWidgets.verticalSeparator, Text('Or')],
              ),
              MyWidgets.horizontalSeparator,
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Pick a Date',
                    style: MyFontStyles.heading2,
                  ),
                  Consumer<PrescriptionPreviewProvider>(
                    builder: (context, provider, child) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: MyWidgets.borderRadius,
                        ),
                        child: GestureDetector(
                            onTap: () async {
                              final _pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                              );
                              if (_pickedDate != null) {
                                // provider.setNextVisitDate(_pickedDate);
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  DateFormat('dd/MM/yy')
                                      .format(provider.nextVisitDate),
                                  style: MyFontStyles.heading2,
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }