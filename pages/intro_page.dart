import 'package:ecommerce_3/pages/add_item_page.dart';
import 'package:ecommerce_3/pages/fire_map.dart';
// import 'package:ecommerce_3/pages/fire_map.dart';
import 'package:ecommerce_3/pages/home_page.dart';
import 'package:ecommerce_3/pages/market_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key) {}

  final user = FirebaseAuth.instance.currentUser!;

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.email!),
          actions: [
            IconButton(
              onPressed: signOutUser,
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  text: 'Home',
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  text: 'Location',
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  text: 'Sell',
                  icon: Icon(
                    Icons.monetization_on,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  text: 'Market',
                  icon: Icon(
                    Icons.shopping_bag,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                // home tab
                HomePage(),

                // location tab
                const FireMap(),

                // sell tab
                const AddItemPage(),

                //market tab
                const MarketPage(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
