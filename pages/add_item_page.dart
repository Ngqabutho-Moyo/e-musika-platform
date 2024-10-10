import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_3/components/my_picture_box.dart';
// import 'package:ecommerce_3/components/my_button.dart';
// import 'package:ecommerce_3/components/my_drawer.dart';
import 'package:ecommerce_3/components/my_text_field.dart';
// import 'package:ecommerce_3/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemState();
}

final user = FirebaseAuth.instance.currentUser!;
XFile? file;
String? path;

class _AddItemState extends State<AddItemPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference reference =
      FirebaseFirestore.instance.collection('products');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                SizedBox(
                  child: file == null
                      ? const Center(
                          child: Text('No picture selected'),
                        )
                      : Center(
                          child: Image.file(File(file!.path)),
                        ),
                ),
                IconButton(
                    onPressed: chooseImage, icon: Icon(Icons.camera_alt)),
                MyTextField(
                    controller: priceController,
                    hintText: 'Price',
                    obscureText: false),
                const SizedBox(
                  height: 15,
                ),
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
      ),
    );
  }

  Future<XFile?> chooseImage() async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void uploadData() async {
    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceImages = referenceRoot.child('products');
    Reference referenceImageToUpload = referenceImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      print(e);
      return;
    }
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
        'uploaded_by': user.email!,
      };
      reference.add(dataToSend);
      // Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your product has been uploaded successfully!'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            );
          });
      file = null;
      nameController.clear();
      descriptionController.clear();
      priceController.clear();
      setState(() {});
    }
  }
}
