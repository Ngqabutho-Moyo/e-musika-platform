import 'package:ecommerce_3/components/my_drawer.dart';
import 'package:ecommerce_3/components/my_product_tile.dart';
import 'package:ecommerce_3/models/shop.dart';
// import 'package:ecommerce_3/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    // access products in shop
    final products = context.watch<Shop>().shop;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Shop Page'),
        actions: [
          // go to cart button
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/cart_page'),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          const SizedBox(
            height: 25,
          ),

          // shop subtitle
          Center(
            child: Text(
              'Prick from our wide range of products',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          // product list
          SizedBox(
            height: 750,
            child: ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  // get individual products from shop
                  final product = products[index];

                  // return as a product tile UI
                  return MyProductTile(product: product);
                }),
          )
        ],
      ),
    );
  }
}
