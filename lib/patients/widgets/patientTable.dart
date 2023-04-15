import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_prescription_frontend/constants/colors.dart';
import 'package:online_prescription_frontend/patients/widgets/editPerson.dart';
import 'package:provider/provider.dart';
import 'dart:core';

import '../provider/patient_provider.dart';

class PatientTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(
      builder: (context, value, child) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.maxFinite,
            child: DataTable(
              sortAscending:
                  value.sortById != -1 && value.sortByLastVisit != -1,
              sortColumnIndex: value.sortById != 0
                  ? 0
                  : value.sortByLastVisit != 0
                      ? 5
                      : null,
              columns: [
                DataColumn(
                  label: Row(
                    children: [
                      Text('ID'),
                      IconButton(
                        icon: Icon(value.sortById == 1
                            ? Icons.keyboard_arrow_up
                            : value.sortById == -1
                                ? Icons.keyboard_arrow_down
                                : Icons.sort),
                        onPressed: () {
                          if (value.sortById == 0 || value.sortById == -1) {
                            value.setSortById(1);
                            value.setSortByLastVisit(0);
                            value.sortList(value.patients);
                          } else {
                            value.setSortById(-1);
                            value.setSortByLastVisit(0);
                            value.sortList(value.patients);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Age')),
                DataColumn(label: Text('Gender')),
                DataColumn(label: Text('Mobile No.')),
                DataColumn(
                  label: Row(
                    children: [
                      Text('Last Visit'),
                      IconButton(
                        icon: Icon(value.sortByLastVisit == 1
                            ? Icons.keyboard_arrow_up
                            : value.sortByLastVisit == -1
                                ? Icons.keyboard_arrow_down
                                : Icons.sort),
                        onPressed: () {
                          if (value.sortByLastVisit == 0 ||
                              value.sortByLastVisit == -1) {
                            value.setSortByLastVisit(1);
                            value.setSortById(0);
                            value.sortList(value.patients);
                          } else {
                            value.setSortByLastVisit(-1);
                            value.setSortById(0);
                            value.sortList(value.patients);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                DataColumn(label: Text('')),
              ],
              rows: value.patients.map((person) {
                return DataRow(
                  cells: [
                    DataCell(Text(person.id.toString())),
                    DataCell(Text(
                      person.name,
                      style: TextStyle(color: MyColors.primaryColor),
                    )),
                    DataCell(Text(person.age.toString())),
                    DataCell(Text(person.gender.name)),
                    DataCell(Text(person.mobileNo)),
                    DataCell(Text(DateFormat('dd MMM yy')
                        .format(person.lastVisit as DateTime)
                        .toString())),
                    DataCell(
                      IconButton(
                          icon: Icon(Icons.edit_outlined),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return EditPersonDialog(
                                  person: person,
                                );
                              })
                          // value.editPerson(person, context),
                          ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
