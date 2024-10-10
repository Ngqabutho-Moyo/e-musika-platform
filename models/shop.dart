import 'package:ecommerce_3/models/product.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  // products for sale
  final List<Product> _shop = [
    Product(
        name: "Jeep Grand Cherokee",
        price: 32000,
        description: '5.0L supercharged V8, serviced, 50000km',
        imagePath: 'assets/images/Jeep Grand Cherokee 1.png'),
    Product(
        name: "Honda Fit Hybrid",
        price: 9800,
        description: 'Lady-driven, accident-free, 80000km',
        imagePath: 'assets/images/Honda Fit Hybrid 1.png'),
    Product(
        name: "Toyota Hilux",
        price: 42000,
        description: 'Serviced last month (April 2024), quick sale',
        imagePath: 'assets/images/Toyota Hilux 1.png'),
    Product(
        name: "Toyota Prius",
        price: 12000,
        description: 'Lady-driven, accident-free, 25000km',
        imagePath: 'assets/images/Toyota Prius 1.png'),
  ];

  // user cart
  List<Product> _cart = [];

  // get product list
  List<Product> get shop => _shop;

  // get user cart
  List<Product> get cart => _cart;

  // add item to cart
  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  // remove item from cart
  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}
