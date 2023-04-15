import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerWidget extends StatefulWidget {
  final Function(DateTime, DateTime) onSelected;
  DateRangePickerWidget({required this.onSelected});

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select date range"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => _selectDate(context, true),
            child: Row(
              children: [
                Icon(Icons.date_range),
                SizedBox(width: 10),
                Text(
                    "Start date: ${DateFormat('dd-MM-yyyy').format(_startDate)}"),
              ],
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () => _selectDate(context, false),
            child: Row(
              children: [
                Icon(Icons.date_range),
                SizedBox(width: 10),
                Text("End date: ${DateFormat('dd-MM-yyyy').format(_endDate)}"),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.onSelected(_startDate, _endDate);
            Navigator.pop(context);
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
