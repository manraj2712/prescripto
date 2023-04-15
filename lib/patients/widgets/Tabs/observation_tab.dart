import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/patients/model/patients.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts_styles.dart';
import '../../../constants/widgets.dart';
import '../../provider/prescription_preview_provider.dart';
import '../bullet_list_form_field.dart';
import 'prescription_dropdown.dart';

SingleChildScrollView ObservationTab(TabController tabController,
    PrescriptionPreviewProvider prescriptionprovider) {
  int editIndexObs = -1;
  final observationKey = GlobalKey<FormState>();
  final complaintController = TextEditingController();
  final sinceController = TextEditingController();
  final observationController = TextEditingController(text: '•');
  final diagnosisController = TextEditingController();

  return SingleChildScrollView(
    child: Form(
      key: observationKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyWidgets.verticalSeparator,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  tabController.animateTo(1);
                },
                child: Text('Next >')),
          ),
          MyWidgets.verticalSeparator,
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyWidgets.horizontalSeparator,
                MyWidgets.horizontalSeparator,
                MyWidgets.horizontalSeparator,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Complaints',
                      style: MyFontStyles.heading2,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.isEmpty ? 'Complaints cannot be empty' : null,
                      controller: complaintController,
                      decoration: InputDecoration(
                        hintText: 'complaints',
                        constraints: BoxConstraints(
                            maxHeight: 40,
                            minHeight: 30,
                            minWidth: 300,
                            maxWidth: 300),
                        contentPadding: EdgeInsets.only(bottom: 5, left: 10),
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
                      // onChanged: (value) {
                      //   prescriptionprovider.complaint = value;
                      // },
                      onSaved: (newValue) =>
                          prescriptionprovider.complaint = newValue!,
                    ),
                  ],
                ),
                MyWidgets.horizontalSeparator,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Since',
                      style: MyFontStyles.heading2,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.isEmpty ? 'Since cannot be empty' : null,
                      controller: sinceController,
                      decoration: InputDecoration(
                        hintText: 'since',
                        constraints: BoxConstraints(
                            maxHeight: 40,
                            minHeight: 30,
                            minWidth: 80,
                            maxWidth: 80),
                        contentPadding: EdgeInsets.only(left: 10, bottom: 5),
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
                      onSaved: (newValue) =>
                          prescriptionprovider.since = int.parse(newValue!),
                    ),
                  ],
                ),
                MyWidgets.horizontalSeparator,
                Consumer<PrescriptionPreviewProvider>(
                  builder: (context, provider, _) {
                    return prescriptionDropDownWidget(
                        columnText: '',
                        value: provider.ObservationtoString(
                            provider.sinceDuration),
                        onChanged: (value) {
                          provider.sinceDuration =
                              provider.getObservationDuration(value!);
                        },
                        hintText: '',
                        items: provider.getListofObservationDuration());
                  },
                ),
                MyWidgets.horizontalSeparator,
                Container(
                  margin: const EdgeInsets.only(top: 28),
                  height: 40,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      iconColor: MaterialStateProperty.all<Color>(
                          MyColors.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: MyWidgets.borderRadius,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (!prescriptionprovider.editModeObservation) {
                        if (observationKey.currentState!.validate()) {
                          prescriptionprovider.addObservation(
                              prescriptionprovider.complaint,
                              prescriptionprovider.since,
                              prescriptionprovider.sinceDuration,
                              prescriptionprovider.diagnosis,
                              prescriptionprovider.observation);
                          observationKey.currentState!.save();
                        }
                        debugPrintSynchronously(
                            prescriptionprovider.observations.toString());
                      } else {
                        prescriptionprovider.updateObservation(
                            prescriptionprovider.complaint,
                            prescriptionprovider.since,
                            prescriptionprovider.sinceDuration,
                            prescriptionprovider.diagnosis,
                            prescriptionprovider.observation);
                        prescriptionprovider.seteditModeObservation(false);
                      }
                      complaintController.clear();
                      diagnosisController.clear();
                      sinceController.clear();
                      observationController.clear();
                    },
                    child: Consumer<PrescriptionPreviewProvider>(
                      builder: (context, provider, child) =>
                          provider.editModeObservation
                              ? Text('Update')
                              : Text('Add'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          MyWidgets.verticalSeparator,
          MyWidgets.verticalSeparator,

          ///Obseravtion Tab Container
          Consumer<PrescriptionPreviewProvider>(
              builder: (context, provider, child) => Container(
                    child: Wrap(
                      children: provider.observations.map((item) {
                        int observationIndex =
                            provider.observations.indexOf(item);
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, bottom: 25),
                          child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.observations[observationIndex]
                                            .complaint,
                                        style: MyFontStyles.heading2,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(provider
                                              .observations[observationIndex]
                                              .since +
                                          " " +
                                          provider
                                              .observations[observationIndex]
                                              .observationDuration
                                              .name)
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      provider
                                          .deleteObservation(observationIndex);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: MyColors.iconColor,
                                    )),
                                provider.editModeObservation
                                    ? IconButton(
                                        onPressed: () {
                                          editIndexObs = observationIndex;

                                          provider.updateObservation(
                                              provider.complaint,
                                              provider.since,
                                              provider.sinceDuration,
                                              provider.diagnosis,
                                              provider.observation);

                                          complaintController.clear();

                                          sinceController.clear();
                                          diagnosisController.clear();
                                          observationController.clear();

                                          provider
                                              .seteditModeObservation(false);
                                        },
                                        icon: observationIndex == editIndexObs
                                            ? Icon(
                                                Icons.check,
                                                color: MyColors.iconColor,
                                              )
                                            : Icon(
                                                Icons.edit_outlined,
                                                color: MyColors.iconColor,
                                              ))
                                    : IconButton(
                                        onPressed: () {
                                          provider.seteditModeObservation(true);
                                          editIndexObs = observationIndex;
                                          complaintController.text = provider
                                              .observations[observationIndex]
                                              .complaint;
                                          sinceController.text = provider
                                              .observations[observationIndex]
                                              .since;
                                          diagnosisController.text = provider
                                                  .observations[
                                                      observationIndex]
                                                  .diagnosis ??
                                              '';
                                          observationController.text = provider
                                                  .observations[
                                                      observationIndex]
                                                  .observation ??
                                              '';
                                          provider.sinceDuration = provider
                                              .observations[observationIndex]
                                              .observationDuration;
                                        },
                                        icon: Icon(
                                          Icons.edit_outlined,
                                          color: MyColors.iconColor,
                                        ),
                                      )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )),
          MyWidgets.verticalSeparator,
          MyWidgets.verticalSeparator,
          Row(
            children: [
              MyWidgets.horizontalSeparator,
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Physical examination/observation',
                        style: MyFontStyles.heading2,
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        child: SizedBox(
                          child: BulletListFormField(
                            validator: null,
                            controller: observationController,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              MyWidgets.horizontalSeparator,
              Flexible(
                child: MyWidgets.textFieldBelowColumn(
                    columnText: 'Diagnosis',
                    controller: diagnosisController,
                    labelText: 'Diagnosis',
                    onsaved: (value) => prescriptionprovider.diagnosis = value!,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter diagnosis';
                      }
                      return null;
                    }),
              ),
              MyWidgets.horizontalSeparator,
            ],
          )
        ],
      ),
    ),
  );
}
