import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyTestProductTile extends StatelessWidget {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('products');
  late Stream<QuerySnapshot> stream;
  Map thisItem;
  MyTestProductTile(
      {super.key,
      required this.reference,
      required this.stream,
      required this.thisItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // product image
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  child: Image.network(thisItem['image']),
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              // product name
              Text(
                thisItem['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              // product description
              Text(
                thisItem['description'],
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),

              // product price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$' + thisItem['price'],
                  ),
                  Text(thisItem['uploaded_by'])
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
