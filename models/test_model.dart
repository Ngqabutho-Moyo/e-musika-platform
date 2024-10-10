import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_3/components/my_button.dart';
import 'package:ecommerce_3/components/my_text_field.dart';
import 'package:ecommerce_3/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference reference =
      FirebaseFirestore.instance.collection('images');

  String imageUrl = '';

  // Future<XFile> chooseImage() async {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              MyTextField(
                  controller: nameController,
                  hintText: 'Product Name',
                  obscureText: false),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  obscureText: false),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                  controller: priceController,
                  hintText: 'Price',
                  obscureText: false),
              const SizedBox(
                height: 25,
              ),
              IconButton(onPressed: pickImage, icon: Icon(Icons.camera_alt)),
              // IconButton(onPressed: chooseImage, icon: Icon(Icons.camera_alt)),
              ElevatedButton(
                  onPressed: uploadData,
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void uploadData() async {
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an image')));
      return;
    }
    if (key.currentState!.validate()) {
      String itemName = nameController.text;
      String itemDesc = descriptionController.text;
      String itemPrice = priceController.text;

      Map<String, String> dataToSend = {
        'name': itemName,
        'description': itemDesc,
        'price': itemPrice,
        'image': imageUrl,
      };
      reference.add(dataToSend);
    }
  }

  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceImages = referenceRoot.child('products');
    Reference referenceImageToUpload = referenceImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      print(e);
      return;
    }
  }
}
