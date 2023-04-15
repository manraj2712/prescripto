import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';

import '../../constants/colors.dart';

// ignore: must_be_immutable
class BulletListFormField extends StatefulWidget {
  final TextEditingController controller;
  String? Function(String?)? validator;
  BulletListFormField({
    this.validator,
    required this.controller,
  });
  @override
  State<BulletListFormField> createState() => _BulletListFormFieldState();
}

class _BulletListFormFieldState extends State<BulletListFormField> {
  bool newLine = false;
  @override
  void initState() {
    widget.controller.addListener(() {
      String note = widget.controller.text;
      if (note.isNotEmpty && note.substring(note.length - 1) == '\u2022') {
        setState(() {
          newLine = true;
        });
      } else {
        setState(() {
          newLine = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      autovalidateMode: AutovalidateMode.always,
      controller: widget.controller,
      onChanged: (value) {
        Future.delayed(const Duration(milliseconds: 0), () {
          if (newLine) {
            return;
          }
          String note = widget.controller.text;
          if (note.isEmpty) {
            widget.controller.text = widget.controller.text + '\u2022';
            widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length));
          }
          if (note.isNotEmpty && note.substring(note.length - 1) == '\n') {
            widget.controller.text = widget.controller.text + '\u2022';
            widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length));
          }
        });
      },
      onSaved: (newValue) {
        String note = widget.controller.text;
        if (note.isNotEmpty && note.substring(note.length - 1) == '\u2022') {
          widget.controller.text = widget.controller.text.substring(
              0, widget.controller.text.length - 1);
        }
      },
      decoration: InputDecoration(
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
    );
  }
}
