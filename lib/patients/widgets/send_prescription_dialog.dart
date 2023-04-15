import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_prescription_frontend/patients/model/patients.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/fonts_styles.dart';
import '../../constants/widgets.dart';
import '../provider/patient_provider.dart';
import 'genderRadioButton.dart';

// ignore: must_be_immutable
class SendPrescriptionDialog extends StatelessWidget {
  final genderMap = {
    ' Male': Gender.Male,
    ' Female': Gender.Female,
  };
  final autocompleteController = TextEditingController();
  final sendPrescriptionKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileNoController = TextEditingController();
  final ageController = TextEditingController();

  FormState? getSendPrescriptionKeyState() {
    return sendPrescriptionKey.currentState;
  }

  SendPrescriptionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patientprovider =
        Provider.of<PatientProvider>(context, listen: false);
    List<String> suggestions = patientprovider.patients.map((e) {
      return '${e.name} , ${e.gender.name}, ${e.age} yrs, ${e.mobileNo}';
    }).toList();
    return Form(
      key: sendPrescriptionKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Find or add patient',
                style: MyFontStyles.heading2,
              ),
              const SizedBox(
                height: 5,
              ),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  List<String> options = suggestions.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  }).toList();
                  if (textEditingValue.text.isNotEmpty) {
                    options.insert(0, 'Add Patient');
                  }
                  return options;
                },
                onSelected: (String selection) {
                  final selectedGender = genderMap[selection.split(',')[1]];
                  if (selection == 'Add Patient') {
                    patientprovider.setEnabled(true);
                    firstNameController.text = '';
                    mobileNoController.text = '';
                    lastNameController.text = '';
                    ageController.text = '';
                  } else {
                    selection.split(',');
                    firstNameController.text = selection.split(',')[0];
                    patientprovider.setFirstName(firstNameController.text);
                    mobileNoController.text = selection.split(',')[3];
                    patientprovider.setMobileNo(mobileNoController.text);
                    lastNameController.text = '';
                    patientprovider.setLastName(lastNameController.text);
                    ageController.text = selection.split(',')[2].split(' ')[1];
                    patientprovider.setAge(int.parse(ageController.text));
                    patientprovider
                        .updateSelectedGender(selectedGender as Gender);
                  }
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    onFieldSubmitted: (String value) {
                      onFieldSubmitted();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Patient',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: Container(
                        height: 200,
                        width: 300,
                        child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              MyWidgets.verticalSeparator,
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'First Name',
                          style: MyFontStyles.heading2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer<PatientProvider>(
                          builder: (context, value, child) {
                            return TextFormField(
                              onChanged: (value) {
                                patientprovider.setFirstName(value);
                              },
                              enabled: value.enabled,
                              controller: firstNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter first name';
                                }
                                return null;
                              },
                              onSaved: (newValue) =>
                                  patientprovider.setFirstName(newValue!),
                              decoration: InputDecoration(
                                constraints: BoxConstraints(
                                    minHeight: 40, maxHeight: 40),
                                contentPadding: MyWidgets.contentpadding(),
                                border: OutlineInputBorder(
                                    borderRadius: MyWidgets.borderRadius,
                                    borderSide: BorderSide(
                                        color: MyColors.containerColor)),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Last Name',
                          style: MyFontStyles.heading2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Consumer<PatientProvider>(
                          builder: (context, value, child) {
                            return TextFormField(
                              onChanged: (value) {
                                patientprovider.setLastName(value);
                              },
                              enabled: value.enabled,
                              controller: lastNameController,
                              onSaved: (newValue) =>
                                  patientprovider.setLastName(newValue!),
                              decoration: InputDecoration(
                                contentPadding: MyWidgets.contentpadding(),
                                constraints: BoxConstraints(
                                    minHeight: 40, maxHeight: 40),
                                border: OutlineInputBorder(
                                    borderRadius: MyWidgets.borderRadius,
                                    borderSide: BorderSide(
                                        color: MyColors.containerColor)),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          MyWidgets.verticalSeparator,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mobile No.',
                style: MyFontStyles.heading2,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    // padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyColors.containerColor),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                    child: Text(
                      '+91',
                    ),
                  ),
                  Expanded(
                    child: Consumer<PatientProvider>(
                      builder: (context, value, child) {
                        return TextFormField(
                          onChanged: (value) {
                            patientprovider.setMobileNo(value);
                          },
                          enabled: value.enabled,
                          controller: mobileNoController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter mobile no.';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(
                              10,
                            ),
                          ],
                          onSaved: (newValue) =>
                              patientprovider.setMobileNo(newValue!),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            contentPadding: MyWidgets.contentpadding(),
                            constraints:
                                BoxConstraints(minHeight: 40, maxHeight: 40),
                            border: OutlineInputBorder(
                                borderRadius: MyWidgets.borderRadius,
                                borderSide:
                                    BorderSide(color: MyColors.containerColor)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          MyWidgets.verticalSeparator,
          Row(
            children: [
              Flexible(
                child: Consumer<PatientProvider>(
                  builder: (context, value, _) {
                    return GenderRadioButtons();
                  },
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Age',
                      style: MyFontStyles.heading2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Consumer<PatientProvider>(
                      builder: (context, value, child) {
                        return TextFormField(
                          onChanged: (value) {
                            patientprovider.setAge(int.parse(value));
                            debugPrintSynchronously(
                                patientprovider.age.toString());
                          },
                          enabled: value.enabled,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter age';
                            }
                            return null;
                          },
                          onSaved: (newValue) =>
                              patientprovider.setAge(int.parse(newValue!)),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(
                              2,
                            ),
                          ],
                          controller: ageController,
                          decoration: InputDecoration(
                            contentPadding: MyWidgets.contentpadding(),
                            constraints:
                                BoxConstraints(minHeight: 40, maxHeight: 40),
                            border: OutlineInputBorder(
                                borderRadius: MyWidgets.borderRadius,
                                borderSide:
                                    BorderSide(color: MyColors.containerColor)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          MyWidgets.verticalSeparator,
        ],
      ),
    );
  }
}
