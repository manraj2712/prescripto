import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../provider/clinic_profile_provider.dart';

class ImagePickerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        onPressed: () async {
          final result =
              await FilePicker.platform.pickFiles(type: FileType.image);
          if (result != null) {
            final file = result.files.first.bytes as Uint8List;
            Provider.of<ClinicProfileProvider>(context).setImage(file);
          }
        },
        child: Row(
          children: [
            Icon(
              Icons.upload_file,
              color: Colors.black,
            ),
            Text(
              'Pick Image',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
