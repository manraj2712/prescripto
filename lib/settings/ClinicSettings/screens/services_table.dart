import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:online_prescription_frontend/constants/colors.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/providers/setting_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/fonts_styles.dart';
import '../models/service_model.dart';

class ServicesTable extends StatefulWidget {
  @override
  _ServicesTableState createState() => _ServicesTableState();
}

class _ServicesTableState extends State<ServicesTable> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late bool _nameAscending;
  late bool _priceAscending;
  late bool _dateAscending;
  late String _sortColumn;

  @override
  void initState() {
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _nameAscending = true;
    _priceAscending = true;
    _dateAscending = true;
    _sortColumn = 'name';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final servicesProvider = Provider.of<SettingProvider>(context);
    final services = servicesProvider.services;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyWidgets.verticalSeparator,
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: Text(
              "Add the services that your clinic offers. You can select these while generating the bills.",
              style: MyFontStyles.heading2,
            ),
          ),
          MyWidgets.verticalSeparator,
          MyWidgets.verticalSeparator,
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Service name",
                        style: MyFontStyles.heading2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: size.width / 4,
                        height: size.height * 0.05,
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 8),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.containerColor),
                                borderRadius: MyWidgets.borderRadius,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.primaryColor),
                                  borderRadius: MyWidgets.borderRadius),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyColors.containerColor),
                                  borderRadius: MyWidgets.borderRadius)),
                        ),
                      ),
                    ],
                  ),
                ),
                MyWidgets.horizontalSeparator,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: MyFontStyles.heading2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: size.width / 8,
                        height: size.height * 0.05,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.containerColor),
                                borderRadius: MyWidgets.borderRadius),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.primaryColor),
                                borderRadius: MyWidgets.borderRadius),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.containerColor),
                                borderRadius: MyWidgets.borderRadius),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MyWidgets.horizontalSeparator,
                Column(
                  children: [
                    Text(
                      "",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          final name = _nameController.text;
                          final price = int.parse(_priceController.text);
                          final service = ServiceModel(
                            name: name,
                            price: price,
                            creationDate: DateTime.now(),
                          );
                          servicesProvider.addService(service);
                          _nameController.clear();
                          _priceController.clear();
                        },
                        child: Text('Add'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          MyWidgets.verticalSeparator,
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
            child: Table(
              // border: MyWidgets.tableBorder(),
              columnWidths: {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(0.7),
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: TextButton(
                        child: Wrap(
                          children: [
                            Text('Service Name', style: MyFontStyles.heading2),
                            arrowIcon(_nameAscending),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _sortColumn = 'name';
                            _nameAscending = !_nameAscending;
                          });
                          servicesProvider.sortServicesBy(
                              _sortColumn, _nameAscending);
                        },
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: TextButton(
                        child: Wrap(
                          children: [
                            Text('Price', style: MyFontStyles.heading2),
                            arrowIcon(_priceAscending),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _sortColumn = 'price';
                            _priceAscending = !_priceAscending;
                          });
                          servicesProvider.sortServicesBy(
                              _sortColumn, _priceAscending);
                        },
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: Wrap(
                            children: [
                              Text('Creation Date',
                                  style: MyFontStyles.heading2),
                              arrowIcon(_dateAscending),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              _sortColumn = 'creationDate';
                              _dateAscending = !_dateAscending;
                            });
                            servicesProvider.sortServicesBy(
                                _sortColumn, _dateAscending);
                          },
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Action',
                          style: MyFontStyles.heading2,
                        ),
                      ),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Table(
              border: MyWidgets.tableBorder(),
              columnWidths: {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(0.7),
              },
              children: [
                ...services.map((service) {
                  return TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              // border: Border(
                              //   right: BorderSide(
                              //     color: Colors.grey[300]!,
                              //   ),
                              // ),
                              ),
                          child: Text(
                            service.name,
                            style: MyFontStyles.heading3,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              // border: Border(
                              //   right: BorderSide(
                              //     color: Colors.grey[300]!,
                              //   ),
                              // ),
                              ),
                          child: Text(
                            service.price.toString(),
                            style: MyFontStyles.heading3,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              // border: Border(
                              //   right: BorderSide(
                              //     color: Colors.grey[300]!,
                              //   ),
                              // ),
                              ),
                          child: Text(
                            DateFormat.yMd().format(service.creationDate),
                            style: MyFontStyles.heading3,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit_outlined),
                              onPressed: () {
                                _showEditDialog(context, service);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline),
                              onPressed: () {
                                servicesProvider.deleteService(service);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text.rich(TextSpan(
                text: services.length.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: " results",
                      style: TextStyle(fontWeight: FontWeight.normal))
                ])),
          )
        ],
      ),
    );
  }

  Icon arrowIcon(bool value) {
    return Icon(
      value ? Icons.arrow_drop_down : Icons.arrow_drop_up,
      color: Colors.black,
    );
  }

  int? _getSortColumnIndex() {
    switch (_sortColumn) {
      case 'name':
        return 0;
      case 'price':
        return 1;
      case 'creationDate':
        return 2;
      default:
        return null;
    }
  }

  bool _getSortAscending() {
    switch (_sortColumn) {
      case 'name':
        return _nameAscending;
      case 'price':
        return _priceAscending;
      case 'creationDate':
        return _dateAscending;
      default:
        return true;
    }
  }
}

void _showEditDialog(BuildContext context, ServiceModel service) {
  final _editNameController = TextEditingController(text: service.name);
  final _editPriceController =
      TextEditingController(text: service.price.toString());
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Edit Service'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editNameController,
                decoration: InputDecoration(
                  labelText: 'Service Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _editPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  final name = _editNameController.text;
                  final price = int.parse(_editPriceController.text);
                  final editedService =
                      service.copyWith(name: name, price: price);
                  Provider.of<SettingProvider>(context, listen: false)
                      .editService(service, editedService);
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ),
          ],
        );
      });
}

SizedBox tableElevatedButton(Size size, SettingProvider provider,
    List<TableRow> tableRow, BuildContext context) {
  return SizedBox(
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
          // if (_textController.text.isNotEmpty) {
          //   provider.addRecord(_textController.text);
          //   tableRow.add(TableRow(children: [
          //     Text(_textController.text),
          //     IconButton(
          //       icon: Icon(Icons.delete),
          //       onPressed: () => provider.deleteRecord(tableRow.length),
          //     ),
          //   ]));
          //   _textController.clear();
        } else {
          MyWidgets.showSnackBar(context, 'Vitals cannot be empty');
        }
      },
      child: Text('Add'),
    ),
  );
}
