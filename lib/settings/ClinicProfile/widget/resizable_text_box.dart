import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';

class ResizableTextBox extends StatefulWidget {
  final TextEditingController controller;

  const ResizableTextBox({Key? key, required this.controller})
      : super(key: key);

  @override
  _ResizableTextBoxState createState() => _ResizableTextBoxState();
}

class _ResizableTextBoxState extends State<ResizableTextBox> {
  bool _resizing = false;
  double _height = 100.0;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 2;
    return GestureDetector(
      onPanDown: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset localOffset = box.globalToLocal(details.globalPosition);
        if (localOffset.dx > box.size.width - 20 &&
            localOffset.dy > box.size.height - 20) {
          setState(() {
            _resizing = true;
          });
        }
      },
      onPanUpdate: (details) {
        if (_resizing) {
          setState(() {
            _height = _height + details.delta.dy;
            _width = _width + details.delta.dx;
          });
        }
      },
      onPanEnd: (_) {
        setState(() {
          _resizing = false;
        });
      },
      child: SizedBox(
        height: _height,
        width: _width,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter the value";
            }
            return null;
          },
          onFieldSubmitted: (value) {},
          maxLines: null,
          controller: widget.controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: MyWidgets.borderRadius),
            enabledBorder: OutlineInputBorder(
              borderRadius: MyWidgets.borderRadius,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: MyWidgets.borderRadius,
            ),
          ),
        ),
      ),
    );
  }
}
