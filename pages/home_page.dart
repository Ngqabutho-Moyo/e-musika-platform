// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_3/components/my_drawer.dart';
import 'package:ecommerce_3/components/my_test_tile.dart';
// import 'package:ecommerce_3/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Stream<QuerySnapshot> _stream =
  //     FirebaseFirestore.instance.collection('products').snapshots();
  String name = '';

  // final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('products');

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('products')
        .orderBy('name')
        .startAt([name]).endAt([name + '\uf8ff']).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search'),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              }),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.5,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Expanded(
        child: GestureDetector(
          onTap: () {},
          child: ListView(
            children: [
              SizedBox(
                height: 750,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      }
                      if (snapshot.hasData) {
                        QuerySnapshot querySnapshot = snapshot.data!;
                        List<QueryDocumentSnapshot> documents =
                            querySnapshot.docs;
                        List<Map> items =
                            documents.map((e) => e.data() as Map).toList();

                        return ListView.builder(
                            itemCount: items.length,
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(15),
                            itemBuilder: (context, index) {
                              Map thisItem = items[index];
                              return MyTestProductTile(
                                reference: _reference,
                                stream: _stream,
                                thisItem: thisItem,
                              );
                            });
                      }
                      return CircularProgressIndicator();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
