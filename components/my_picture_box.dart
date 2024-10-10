import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPictureBox extends StatelessWidget {
  late XFile file;
  MyPictureBox({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 300,
        child: Center(
          child: Image.file(File(file.path)),
        ),
      ),
    );
  }
}
