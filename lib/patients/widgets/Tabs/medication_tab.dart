import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/patients/widgets/Tabs/prescription_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_styles.dart';
import '../../../constants/widgets.dart';
import '../../model/patients.dart';
import '../../provider/prescription_preview_provider.dart';

SingleChildScrollView MedicationTab(TabController tabController,
    PrescriptionPreviewProvider prescriptionprovider) {
  final medicineNameController = TextEditingController();
  final medicineQuantityController = TextEditingController();
  final medicineWhenController = TextEditingController();
  final medicineFrequencyController = TextEditingController();
  final medicineDurationController = TextEditingController();
  final medicineInstructionsController = TextEditingController();
  final medicineAlternateController = TextEditingController();

  final medicationKey = GlobalKey<FormState>();
  int editIndexMed = -1;
  return SingleChildScrollView(
    child: Form(
      key: medicationKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyWidgets.verticalSeparator,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  tabController.animateTo(3);
                },
                child: Text('Next >')),
          ),
          MyWidgets.verticalSeparator,
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyWidgets.horizontalSeparator,
              // Medicine name field
              Flexible(
                  child: MyWidgets.textFieldBelowColumn(
                columnText: 'Medicine Name',
                controller: medicineNameController,
                labelText: 'Medicine Name',
                onsaved: (value) => prescriptionprovider.medicineName = value!,
                validator: (String? value) {
                  if (value!.isEmpty) return 'Please enter a value';
                  return null;
                },
              )),
              MyWidgets.horizontalSeparator,
              // When field
              Consumer<PrescriptionPreviewProvider>(
                builder: (context, provider, _) {
                  return Flexible(
                      child: prescriptionDropDownWidget(
                          columnText: 'When',
                          value: provider.medicineWhen,
                          onChanged: (value) {
                            provider.medicineWhen = value.toString();
                          },
                          items: [
                            'Morning',
                            'Afternoon',
                            'Evening',
                            'Night',
                            '2 times a day',
                            '3 times a day',
                            '4 times a day',
                            '5 times a day',
                            '6 times a day',
                            'SOS',
                            'STAT'
                                'Before Meal',
                            'After Meal',
                            'With Meal',
                            'Empty Stomach'
                          ],
                          hintText: 'When'));
                },
              ),
              MyWidgets.horizontalSeparator,
              // Dose Quantity field
              Flexible(
                  child: MyWidgets.textFieldBelowColumn(
                      columnText: 'Dose Quantity',
                      controller: medicineQuantityController,
                      labelText: 'Dose Quantity',
                      onsaved: (value) =>
                          prescriptionprovider.doseQuantity = value!,
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Please enter a value';
                        return null;
                      })),
              MyWidgets.horizontalSeparator,
              // Dose Unit field
              prescriptionDropDownWidget(
                  columnText: 'Dose Unit',
                  value: prescriptionprovider.doseUnit,
                  onChanged: (value) {
                    prescriptionprovider.doseUnit = value.toString();
                  },
                  items: <String>[
                    'Tablet',
                    'Capsule',
                    'Tsp',
                    'Mg',
                    'mL',
                    'grams',
                    'Drops',
                    'Puffs'
                  ],
                  hintText: 'Dose Unit'),
              MyWidgets.horizontalSeparator,
            ],
          ),
          MyWidgets.verticalSeparator,
          Row(
            children: [
              MyWidgets.horizontalSeparator,
              // Repeat field
              Consumer<PrescriptionPreviewProvider>(
                  builder: (context, values, child) {
                return Flexible(
                    child: prescriptionDropDownWidget(
                        columnText: 'Repeat',
                        value: values.repeat,
                        onChanged: (value) {
                          values.repeat = value.toString();
                        },
                        items: <String>['Daily', 'Weekly', 'Monthly'],
                        hintText: 'Repeat'));
              }),
              MyWidgets.horizontalSeparator,
              // For field
              Flexible(
                  child: MyWidgets.textFieldBelowColumn(
                      columnText: 'For',
                      controller: medicineDurationController,
                      labelText: 'For',
                      onsaved: (value) =>
                          prescriptionprovider.forValue = value!,
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Please enter a value';
                        return null;
                      })),
              MyWidgets.horizontalSeparator,
              // For Unit field
              Flexible(
                  child: prescriptionDropDownWidget(
                columnText: '',
                value: prescriptionprovider.forUnit,
                onChanged: (value) {
                  prescriptionprovider.forUnit = value.toString();
                },
                items: <String>['Days', 'Weeks', 'Months'],
                hintText: 'For Unit',
              )),
            ],
          ),
          MyWidgets.verticalSeparator,
          Row(
            children: [
              MyWidgets.horizontalSeparator,
              // Special Instructions field
              Flexible(
                  child: MyWidgets.textFieldBelowColumn(
                      columnText: 'Special Instructions',
                      controller: medicineInstructionsController,
                      labelText: 'Special Instructions',
                      onsaved: (value) =>
                          prescriptionprovider.specialInstructions = value!,
                      validator: (String? value) {
                        return null;
                      })),
              MyWidgets.horizontalSeparator,
              // Alternate Medicine field
              Flexible(
                  child: MyWidgets.textFieldBelowColumn(
                      columnText: 'Alternate Medicine',
                      controller: medicineAlternateController,
                      labelText: 'Alternate Medicine',
                      onsaved: (value) =>
                          prescriptionprovider.alternateMedicine = value!,
                      validator: (String? value) {
                        return null;
                      })),
              MyWidgets.horizontalSeparator,

              ///Medication Tab Container
              Consumer<PrescriptionPreviewProvider>(
                builder: (context, value, child) {
                  return Container(
                    margin: const EdgeInsets.only(top: 28),
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () {
                        if (!prescriptionprovider.editModeMedication) {
                          if (medicationKey.currentState!.validate()) {
                            medicationKey.currentState!.save();
                            prescriptionprovider.addMedicine(Medicine(
                                forvalue:
                                    int.parse(prescriptionprovider.forValue),
                                name: prescriptionprovider.medicineName,
                                when: prescriptionprovider.medicineWhen,
                                alternateMedicine: prescriptionprovider
                                    .alternateMedicine
                                    .toString(),
                                quantity: int.parse(
                                    prescriptionprovider.doseQuantity),
                                specialInstruction:
                                    prescriptionprovider.specialInstructions,
                                forUnit: prescriptionprovider.getDurationUnit(
                                    prescriptionprovider.forUnit),
                                frequency:
                                    prescriptionprovider.medicineFrequency,
                                doseUnit: prescriptionprovider.getQuantityUnit(
                                    prescriptionprovider.doseUnit)));
                            medicineNameController.clear();
                            medicineDurationController.clear();
                            medicineInstructionsController.clear();
                            medicineAlternateController.clear();
                            medicineQuantityController.clear();
                          }
                        } else {
                          medicationKey.currentState!.validate();
                          medicationKey.currentState!.save();
                          medicineNameController.text = prescriptionprovider
                              .medication[editIndexMed].name;
                          medicineDurationController.text = prescriptionprovider
                              .medication[editIndexMed].forvalue
                              .toString();
                          medicineInstructionsController.text =
                              prescriptionprovider
                                  .medication[editIndexMed].specialInstruction;
                          medicineAlternateController.text =
                              prescriptionprovider
                                  .medication[editIndexMed].alternateMedicine;
                          medicineQuantityController.text = prescriptionprovider
                              .medication[editIndexMed].quantity
                              .toString();
                          medicineFrequencyController.text =
                              prescriptionprovider
                                  .medication[editIndexMed].frequency;
                          prescriptionprovider.deleteMedicine(editIndexMed);
                          prescriptionprovider.insertMedicine(
                              editIndexMed,
                              Medicine(
                                name: medicineNameController.text,
                                quantity:
                                    int.parse(medicineFrequencyController.text),
                                doseUnit: prescriptionprovider.getQuantityUnit(
                                    prescriptionprovider.doseUnit),
                                when: prescriptionprovider.medicineWhen,
                                frequency: prescriptionprovider.frequency,
                                forvalue:
                                    int.parse(medicineDurationController.text),
                                forUnit: prescriptionprovider.getDurationUnit(
                                    prescriptionprovider.forUnit),
                                specialInstruction:
                                    medicineInstructionsController.text,
                                alternateMedicine:
                                    medicineAlternateController.text,
                              ));
                          // prescriptionprovider.updateMedication(
                          //     index: editIndexMed,
                          //     forDuration:
                          //         prescriptionprovider.forController.text,
                          //     medicineName: prescriptionprovider
                          //         .medicineNameController.text,
                          //     when: prescriptionprovider.when,
                          //     doseQuantity: prescriptionprovider
                          //         .doseQuantityController.text,
                          //     doseUnit: prescriptionprovider.doseUnit,
                          //     repeat: prescriptionprovider.repeat,
                          //     specialInstructions: prescriptionprovider
                          //         .specialInstructionsController.text,
                          //     alternateMedicine: prescriptionprovider
                          //         .alternateMedicineController.text,
                          //     forDurationUnit: prescriptionprovider.forUnit);
                          prescriptionprovider.seteditModeMedication(false);
                        }
                        medicineNameController.clear();
                        medicineDurationController.clear();
                        medicineInstructionsController.clear();
                        medicineAlternateController.clear();
                        medicineQuantityController.clear();
                        medicineFrequencyController.clear();
                        medicineWhenController.clear();
                      },
                      child: value.editModeMedication
                          ? Text('Update')
                          : Text('Add'),
                    ),
                  );
                },
              ),
              MyWidgets.horizontalSeparator,
            ],
          ),
          MyWidgets.verticalSeparator,
          SizedBox(height: 16),

          SizedBox(height: 16),

          //The container of medication value
          Consumer<PrescriptionPreviewProvider>(
              builder: (context, provider, child) {
            return Container(
              child: Wrap(
                children: [
                  for (var medindex = 0;
                      medindex < prescriptionprovider.medication.length;
                      medindex++)
                    Container(
                      constraints: BoxConstraints.tightFor(),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColors.containerColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  prescriptionprovider
                                      .medication[medindex].name,
                                  style: MyFontStyles.heading2,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                if (prescriptionprovider.medication[medindex]
                                    .alternateMedicine.isNotEmpty)
                                  Text(
                                    "Alternate: " +
                                        prescriptionprovider
                                            .medication[medindex]
                                            .alternateMedicine,
                                    style: MyFontStyles.heading4,
                                  ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  prescriptionprovider
                                          .medication[medindex].quantity
                                          .toString() +
                                      " " +
                                      prescriptionprovider.medication[medindex]
                                          .getQuantityString()
                                      // ['doseUnit']!
                                      +
                                      ', ' +
                                      prescriptionprovider
                                          .medication[medindex].when
                                      // ['when']!
                                      +
                                      ', ' +
                                      prescriptionprovider
                                          .medication[medindex].frequency
                                      // ['repeat']!
                                      +
                                      ' for ' +
                                      prescriptionprovider
                                          .medication[medindex].forvalue
                                          .toString()
                                      // ['for']!
                                      +
                                      ' ' +
                                      Medicine.getDurationString(
                                          prescriptionprovider
                                              .medication[medindex].forUnit)
                                      // ['forUnit']!
                                      +
                                      ', ' +
                                      prescriptionprovider.medication[medindex]
                                          .specialInstruction
                                  // ['specialInstructions']!
                                  ,
                                  style: MyFontStyles.heading5,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                // provider.removeMedication(medindex);
                                provider.deleteMedicine(medindex);
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: MyColors.iconColor,
                              )),
                          !provider.editModeMedication
                              ? IconButton(
                                  onPressed: () {
                                    editIndexMed = provider.medication
                                        .indexOf(provider.medication[medindex]);
                                    provider.seteditModeMedication(true);
                                    medicineNameController.text =
                                            provider.medication[medindex].name
                                        // ['name']!
                                        ;
                                    medicineQuantityController.text = provider
                                            .medication[medindex].quantity
                                            .toString()
                                        // ['doseQuantity']!
                                        ;
                                    provider.doseUnit = provider
                                            .medication[medindex]
                                            .getQuantityString()
                                        // ['doseUnit']!
                                        ;
                                    provider.medicineWhen =
                                            provider.medication[medindex].when
                                        // ['when']!
                                        ;
                                    provider.repeat = provider
                                            .medication[medindex].frequency
                                        // ['repeat']!
                                        ;
                                    medicineDurationController.text = provider
                                            .medication[medindex].forvalue
                                            .toString()
                                        // ['for']!
                                        ;
                                    provider.forUnit =
                                            Medicine.getDurationString(provider
                                                .medication[medindex].forUnit)
                                        // ['forUnit']!
                                        ;
                                    medicineInstructionsController.text =
                                            provider.medication[medindex]
                                                .specialInstruction
                                        // ['specialInstructions']!
                                        ;
                                    medicineAlternateController.text = provider
                                            .medication[medindex]
                                            .alternateMedicine
                                        // ['alternateMedicine']!
                                        ;
                                    provider.updateMedicine(
                                        Medicine(
                                            name: provider.medicineName,
                                            quantity: int.parse(
                                                provider.doseQuantity),
                                            forUnit: provider.getDurationUnit(
                                                provider.forUnit),
                                            when: provider.medicineWhen,
                                            frequency:
                                                provider.medicineFrequency,
                                            forvalue:
                                                int.parse(provider.forValue),
                                            doseUnit: provider.getQuantityUnit(
                                                provider.doseUnit),
                                            specialInstruction:
                                                provider.specialInstructions,
                                            alternateMedicine:
                                                provider.alternateMedicine),
                                        medindex);
                                    // provider.updateMedication(
                                    //     index: medindex,
                                    //     forDuration: int.parse(
                                    //         provider.forController.text),
                                    //     medicineName: provider
                                    //         .medicineNameController.text,
                                    //     when: provider.when,
                                    //     doseQuantity: int.parse(provider
                                    //         .doseQuantityController.text),
                                    //     doseUnit: provider
                                    //         .medication[medindex].quantityUnit,
                                    //     repeat: provider.repeat,
                                    //     specialInstructions: provider
                                    //         .specialInstructionsController.text,
                                    //     alternateMedicine: provider
                                    //         .alternateMedicineController.text,
                                    //     forDurationUnit: provider
                                    //         .medication[medindex].durationUnit);
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: MyColors.iconColor,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    editIndexMed = provider.medication
                                        .indexOf(provider.medication[medindex]);
                                    provider.seteditModeMedication(false);
                                    provider.updateMedicine(
                                        Medicine(
                                            alternateMedicine:
                                                medicineAlternateController
                                                    .text,
                                            forvalue: int.parse(
                                                medicineDurationController
                                                    .text),
                                            forUnit: DurationUnit.days,
                                            frequency: frequency,
                                            name: medicineNameController.text,
                                            quantity: int.parse(
                                                medicineQuantityController
                                                    .text),
                                            doseUnit: provider.getQuantityUnit(
                                                provider.doseUnit),
                                            specialInstruction:
                                                medicineInstructionsController
                                                    .text,
                                            when: medicineWhenController.text),
                                        editIndexMed);
                                    medicineNameController.clear();
                                    medicineQuantityController.clear();
                                    medicineWhenController.clear();
                                    medicineFrequencyController.clear();
                                    medicineDurationController.clear();
                                    medicineInstructionsController.clear();
                                    medicineAlternateController.clear();
                                    // doseQuantityController.clear();
                                    // doseUnit = 'Tablet';
                                    // when = 'Morning';
                                    // repeat = 'Daily';
                                    // forController.clear();
                                    // forUnit = 'Days';
                                    // specialInstructionsController
                                    //     .clear();
                                    // provider.alternateMedicineController
                                    //     .clear();
                                  },
                                  icon: editIndexMed == medindex
                                      ? Icon(
                                          Icons.check,
                                          color: MyColors.iconColor,
                                        )
                                      : Icon(
                                          Icons.edit_outlined,
                                          color: MyColors.iconColor,
                                        )),
                        ],
                      ),
                    ),
                ],
              ),
            );
          })
        ],
      ),
    ),
  );
}
