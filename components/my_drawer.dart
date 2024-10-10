import 'package:ecommerce_3/components/my_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(Icons.shopping_bag,
                      size: 72,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
              //home tile
              MyListTile(
                  text: 'Home',
                  icon: Icons.home,
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.pushNamed(context, '/home_page');
                  }),
              //shop tile
              MyListTile(
                  text: 'Sell',
                  icon: Icons.money,
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.pushNamed(context, '/add_item_page');
                  }),
              //cart tile
              MyListTile(
                  text: 'My Location',
                  icon: Icons.my_location_outlined,
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigator.pushNamed(context, routeName)
                    Navigator.pushNamed(context, '/map_page');
                  }),
            ],
          ),

          //exit
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
                text: 'Logout', icon: Icons.logout, onTap: signOutUser),
          ),
        ],
      ),
    );
  }
}
