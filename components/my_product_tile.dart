// import 'dart:js';

import 'package:ecommerce_3/models/product.dart';
import 'package:ecommerce_3/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyProductTile extends StatelessWidget {
  final Product product;

  const MyProductTile({super.key, required this.product});

  // add to cart when button is pressed
  void addToCart(BuildContext context) {
    // show dialogue box to ask user to confirm to add to cart
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text('Add to cart?'),
              actions: [
                // cancel button
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                // confirm button
                MaterialButton(
                  onPressed: () {
                    // pop dialogue box
                    Navigator.pop(context);

                    // add to cart
                    context.read<Shop>().addToCart(product);
                  },
                  child: const Text('Yes'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
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
                    child: Image.asset(product.imagePath)),
              ),
              const SizedBox(
                height: 25,
              ),

              // product name
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              // product description
              Text(
                product.description,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ],
          ),

          // product price + add to cart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // price
              Text('\$' + product.price.toStringAsFixed(2)),

              // add to cart
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                      onPressed: () => addToCart(context),
                      icon: const Icon(Icons.add))),
            ],
          ),
        ],
      ),
    );
  }
}
