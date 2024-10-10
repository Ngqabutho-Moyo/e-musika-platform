import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShareLocation extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  ShareLocation({super.key});

  Future<void> shareLocation() async {
    final Geolocator geolocator = Geolocator();
    final Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (currentLocation != null) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('locations').doc(user.toString()).set({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
      });
    } else {
      print('Location not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
