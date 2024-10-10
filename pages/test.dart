// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_2/components/my_drawer.dart';
// import 'package:ecommerce_2/components/my_product_tile.dart';
// import 'package:flutter/material.dart';

// class TestList extends StatelessWidget {
//   TestList({Key? key}) : super(key: key) {
//     _stream = _reference.snapshots();
//   }

//   CollectionReference _reference =
//       FirebaseFirestore.instance.collection('images');
//   late Stream<QuerySnapshot> _stream;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           foregroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: const Text('Shop Page'),
//           actions: [
//             // go to cart button
//             IconButton(
//               onPressed: () => Navigator.of(context).pushNamed('/cart_page'),
//               icon: const Icon(Icons.shopping_cart),
//             ),
//           ],
//         ),
//         drawer: const MyDrawer(),
//         backgroundColor: Theme.of(context).colorScheme.background,
//         body: ListView(children: [
//           const SizedBox(
//             height: 25,
//           ),

//           // shop subtitle
//           Center(
//             child: Text(
//               'Prick from our wide range of products',
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.inversePrimary),
//             ),
//           ),
//           const SizedBox(
//             height: 25,
//           ),

//           Center(
//               child: StreamBuilder<QuerySnapshot>(
//                   stream: _stream,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return Center(
//                         child: Text('${snapshot.error}'),
//                       );
//                     }
//                     if (snapshot.hasData) {
//                       QuerySnapshot querySnapshot = snapshot.data!;
//                       List<QueryDocumentSnapshot> documents =
//                           querySnapshot.docs;
//                       List<Map> items =
//                           documents.map((e) => e.data() as Map).toList();

//                       return ListView.builder(
//                         itemCount: items.length,
//                         scrollDirection: Axis.vertical,
//                         padding: const EdgeInsets.all(15),
//                         itemBuilder: (context, index) {
//                           final thisItem = items[index];
//                           return MyProductTile(product: thisItem);
//                         },
//                       );
//                     }
//                   }))
//         ]));
//   }
// }
