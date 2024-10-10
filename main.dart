import 'package:ecommerce_3/firebase_options.dart';
import 'package:ecommerce_3/models/shop.dart';
// import 'package:ecommerce_3/pages/add_item_page.dart';
// import 'package:ecommerce_3/pages/home_page.dart';
import 'package:ecommerce_3/pages/auth_page.dart';
import 'package:ecommerce_3/pages/fire_map.dart';
import 'package:ecommerce_3/pages/home_page.dart';
// import 'package:ecommerce_3/pages/home_page.dart';
import 'package:ecommerce_3/pages/intro_page.dart';
import 'package:ecommerce_3/pages/login_or_register.dart';
import 'package:ecommerce_3/pages/market_page.dart';
// import 'package:ecommerce_3/pages/map_page.dart';
import 'package:ecommerce_3/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  FlutterError.onError = (details) {
    print('Error:\t${details.exception}');
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MarketPage(),
      theme: lightMode,
      routes: {
        '/intro_page': (context) => IntroPage(),
        '/auth_page': (context) => const AuthPage(),
        // '/home_page': (context) => HomePage(),
        // '/cart_page': (context) => const CartPage(),
        '/fire_map': (context) => const FireMap(),
        // '/add_item_page': (context) => const AddItemPage(),
      },
    );
  }
}
