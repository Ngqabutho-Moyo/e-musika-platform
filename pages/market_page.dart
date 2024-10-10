import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' hide LocationAccuracy;

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  // late Position location;
  List<Marker> _markers = [];
  List<Marker> _list = [];
  LatLng? _currentPosition = null;

  Future<Position> getLocation() async {
    await Geolocator.requestPermission();
    Position location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    // current_location = location;
    _list.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(location.latitude, location.longitude),
        infoWindow: const InfoWindow(
          title: 'My Position',
        ),
      ),
    );
    _list.add(
      const Marker(
        markerId: MarkerId('1'),
        position: LatLng(-17.8163, 31.0635),
        infoWindow: InfoWindow(
          title: 'Another Position',
        ),
      ),
    );
    return location;
  }
  // final Position pos=

  // Position currentLocation=getLocation();

  double? dist;
  // List<Marker> _marker = [];
  // Future<Position> pos =
  //     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

  Future<double> calculateDistance(LatLng from) async {
    final location = await getLocation();
    final distance = await Geolocator.distanceBetween(
        location.latitude, location.longitude, from.latitude, from.longitude);
    return distance;
  }

  Location _locationController = new Location();
  GoogleMapController? mapController;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  late int? no_of_records = 0;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('products');

  void fetchResults() async {
    final double distance = await calculateDistance(LatLng(-17.8163, 31.0635));
    dist = distance;
    _reference
        .where('name', isEqualTo: 'Cattle')
        .get()
        .then((QuerySnapshot snapshot) {
      no_of_records = snapshot.docs.length;
      setState(() {});
      // snapshot.docs.forEach((doc) {
      //   print('The console says ${doc['description']} ${distance}');
      //   // dist = distance;
      // });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // super.initState();
    _markers.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    // final distance = calculateDistance(LatLng(-17.8163, 31.0635));
    fetchResults();
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-17.8163, 31.0635),
          zoom: 15,
        ),
        markers: {
          // Marker(
          //   markerId: MarkerId('1'),
          //   position:
          // ),
        },
      ),
    );
  }
}
