import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/providers/setting_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants/widgets.dart';

class VitalsTable extends StatefulWidget {
  @override
  _VitalsTableState createState() => _VitalsTableState();
}

class _VitalsTableState extends State<VitalsTable> {
  List<String> autoCompleteItems = [
    "Weight (Kg)",
    "Diastolic BP (mmHg)",
    "Systolic BP (mmHg)",
    "Temperature (F)"
  ];
  bool _ascending = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingProvider>(context);
    final size = MediaQuery.of(context).size;

    List<TableRow> tableRow = [];
    for (int i = 0; i < provider.records.length; i++) {
      tableRow.add(TableRow(children: [
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              provider.records[i].name,
              style: MyFontStyles.heading3,
            )),
        IconButton(
          icon: Icon(Icons.delete_outline_outlined, size: 20),
          onPressed: () => provider.deleteRecord(i),
        ),
      ]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyWidgets.verticalSeparator,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Add the vitals that you want to record for a patient visiting the clinic.",
            style: MyFontStyles.heading2,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width / 2,
                height: size.height * 0.05,
                child: Autocomplete<String>(
                  onSelected: (option) {
                    provider.vitalsController.text = option;
                  },
                  optionsBuilder: ((textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    } else
                      return autoCompleteItems.where((element) => element
                          .contains(textEditingValue.text.toLowerCase()));
                  }),
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    return tableTextField(textEditingController, focusNode,
                        onFieldSubmitted, provider);
                  },
                ),
              ),
            ),
            MyWidgets.horizontalSeparator,
            SizedBox(
              height: size.height * 0.05,
              child: ElevatedButton(
                onPressed: () {
                  if (provider.vitalsController.text.isNotEmpty) {
                    provider.addRecord(provider.vitalsController.text);
                    tableRow.add(TableRow(children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            provider.vitalsController.text,
                            style: MyFontStyles.heading2,
                          )),
                      IconButton(
                        icon: Icon(Icons.delete_outline_outlined, size: 20),
                        onPressed: () => provider.deleteRecord(tableRow.length),
                      ),
                    ]));
                    provider.vitalsController.clear();
                  } else {
                    MyWidgets.showSnackBar(context, 'Vitals cannot be empty');
                  }
                },
                child: Text('Add'),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _ascending = !_ascending;
                        });
                        provider.sortRecords(_ascending);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          // width: 100,
                          child: Row(
                            children: [
                              Text(
                                'Vital Name',
                                style: MyFontStyles.heading2,
                              ),
                              Icon(
                                _ascending
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                      child: Center(
                          child: Text(
                    'Action',
                    style: MyFontStyles.heading2,
                  ))),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: MyWidgets.tableBorder(),
            children: [...tableRow],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text.rich(TextSpan(
              text: provider.records.length.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: " results",
                    style: TextStyle(fontWeight: FontWeight.normal))
              ])),
        )
      ],
    );
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
        focusedBorder: OutlineInputBorder(
            borderRadius: MyWidgets.borderRadius,
            borderSide: BorderSide(color: Colors.blue)),
        border: OutlineInputBorder(
            borderRadius: MyWidgets.borderRadius,
            borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(
            borderRadius: MyWidgets.borderRadius,
            borderSide: BorderSide(color: Colors.grey.shade300)),
      ),
      onSubmitted: (value) {
        textEditingController.clear();
        provider.vitalsController.text = value;
        provider.addRecord(provider.vitalsController.text);
      },
    );
  }
}
