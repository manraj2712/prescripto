import 'package:flutter/material.dart';

class MedicinesTableWidgets {
  static List<DataColumn> dataColumns(String heading) {
    return columns.map((e) => DataColumn(label: Text(heading))).toList();
  }

  static const columns = [
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Quantity')),
    DataColumn(label: Text('When')),
    DataColumn(label: Text('Frequency')),
    DataColumn(label: Text('Duration')),
  ];
}
