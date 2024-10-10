import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final ImagePicker picker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;

  void uploadImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final TaskSnapshot taskSnapshot =
          await storage.ref('images/${image.name}').putFile(File(image.path));
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print(downloadUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconButton(onPressed: uploadImage, icon: Icon(Icons.camera_alt)),
            // ElevatedButton(onPressed: onPressed, child: child)
          ],
        ),
      ),
    );
  }
}
