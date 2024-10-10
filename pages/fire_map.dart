import 'dart:async';
// import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_3/pages/add_item_page.dart';
import 'package:ecommerce_3/pages/intro_page.dart';
// import 'package:ecommerce_3/pages/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' hide LocationAccuracy;
import 'package:rxdart/rxdart.dart';

class FireMap extends StatefulWidget {
  const FireMap({super.key});

  @override
  State<FireMap> createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  Location _locationController = new Location();
  GoogleMapController? mapController;
  int _markerIdCounter = 1;
  CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(19.07, 72.87),
    zoom: 15,
  );

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GeoFlutterFire geo = GeoFlutterFire();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  LatLng? markerPosition;
  // List<<GeoPoint>dynamic?> x = [];
  List<GeoPoint> coordinates = [];
  List<String> users = [];
  // GeoPoint? x;

  BehaviorSubject<double> radius = BehaviorSubject.seeded(100);
  Stream<dynamic>? query;
  StreamSubscription? subscription;
  String? items;

  final CollectionReference ref =
      FirebaseFirestore.instance.collection('firemap_locations');

  Future<Position> getLocation() async {
    await Geolocator.requestPermission();
    Position location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    return location;
  }

  void _updateQuery(value) {
    final zoomMap = {
      100.0: 5.0,
      200.0: 10.0,
      300.0: 15.0,
      400.0: 20.0,
      500.0: 25.0
    };
    final zoom = zoomMap[value];
    mapController?.moveCamera(CameraUpdate.zoomTo(zoom!));
    setState(() {
      radius.add(value);
      // getData;
    });
  }

  Future<void> getCollection() async {
    // for (String i in users) {
    //   print('The names are $i');
    // }
    try {
      QuerySnapshot snapshot = await ref.get();
      snapshot.docs.forEach((DocumentSnapshot value) async {
        // print('The collection console says ${(value['position.geopoint'])}');
        // x.add((value['position.geopoint']));
        users.add(value['name']);
        coordinates.add(value['position.geopoint']);
        // for (GeoPoint i in coordinates) {
        //   print('${i.latitude} ${i.longitude}');
        // }
        // for (String i in users) {
        //   print('The names are $i');
        // }
      });
      // List<dynamic> result = snapshot.docs.map((doc) => doc.data()).toList();
      // print('The collection console says $result');
      // x!.addAll(result);
      // print('The collection console says x=$x');
      // return result;
    } catch (error) {
      print(error);
      // return null;
    }
  }

  // var docs = FirebaseFirestore.instance.collection('firemap_locations').get();

  // void _buildMarkers() {
  //   List<Marker> markers = [];
  //   for (int i = 0; i < x.length; i++) {
  //     markers.add(Marker(
  //         markerId: MarkerId(i.toString()),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(
  //           BitmapDescriptor.hueRed,
  //         ),
  //         position: LatLng(x[i].latitude, x[i].longitude),
  //         infoWindow: InfoWindow(
  //           title: i.toString(),
  //         )));
  //   }
  //   setState(() {
  //     markers[MarkerId('Marker1')] = markers;
  //   });
  //   ;
  // }

  @override
  Widget build(BuildContext context) {
    // _buildMarkers();
    // print('The user coordinates are as follows:');
    // getCollection();
    // List<LatLng> _markers = [];
    // for (int i = 0; i < x.length; i++) {
    //   _markers.add(LatLng(x[i].latitude, x[i].longitude));
    // }
    // ;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kInitialPosition,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            // mapType: MapType.hybrid,
            compassEnabled: true,
            onCameraMove: _updateCameraPosition,
            markers: Set<Marker>.of(markers.values),
            // markers: _buildMarkers(),
            // trafficEnabled: true,
            zoomControlsEnabled: false,
          ),
          Positioned(
            bottom: 40,
            right: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 40,
                height: 40,
                child: IconButton(
                  padding: const EdgeInsets.all(3),
                  icon: Icon(
                    Icons.pin_drop,
                    color: Colors.red.shade500,
                    size: 50,
                  ),
                  onPressed: _addGeoPoint,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 15,
            child: Slider(
              inactiveColor: Colors.grey,
              activeColor: Colors.blue.shade500,
              thumbColor: Colors.blue.shade500,
              min: 100,
              max: 500,
              divisions: 4,
              value: radius.value,
              label: 'Radius ${radius.value}km',
              onChanged: _updateQuery,
            ),
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    // print('The user coordinates are as follows:');
    // getCollection();
    // getData;
    _startQuery();
    setState(() {
      // getData;
      mapController = controller;
    });
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      _kInitialPosition = position;
    });
  }

  Future _animateToUser(double lat, double long) async {
    return mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 15,
        ),
      ),
    );
  }

  Future<DocumentReference> _addGeoPoint() async {
    Position position = await getLocation();
    await _animateToUser(position.latitude, position.longitude);
    GeoFirePoint point =
        geo.point(latitude: position.latitude, longitude: position.longitude);
    return firestore.collection('firemap_locations').add({
      'position': point.data,
      'name': user.email,
    });
  }

  Future<Map<MarkerId, Marker>> _updateMarkers(
      List<DocumentSnapshot> documentList) async {
    mapController?.dispose();
    Position userCurrentLocation = await getLocation();
    GeoFirePoint point = geo.point(
        latitude: userCurrentLocation.latitude,
        longitude: userCurrentLocation.longitude);
    for (var document in documentList) {
      GeoPoint position = document['position']['geopoint'];
      var distance =
          point.distance(lat: position.latitude, lng: position.longitude);
      // final String markerIdVal = 'Marker-$_markerIdCounter';

      final String markerIdVal = user.email!;
      final MarkerId markerId = MarkerId(markerIdVal);
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
            title: markerIdVal, snippet: '${distance}km from your location'),
        onTap: () => _onMarkerTapped(markerId),
      );
      if (mounted) {
        setState(() {
          markers[markerId] = marker;
        });
      }
    }
    return markers;
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
            iconParam: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen));
        markers[markerId] = newMarker;
        markerPosition = null;
      });
    }
  }

  void _startQuery() async {
    Position pos = await getLocation();
    // var ref = firestore.collection('firemap_locations');
    GeoFirePoint center =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);
    subscription = radius.switchMap((rad) {
      return geo.collection(collectionRef: ref).within(
          center: center, radius: rad, field: 'position', strictMode: true);
    }).listen(_updateMarkers);
  }

  // String? getData() {
  //   String? data;
  //   FirebaseFirestore.instance
  //       .collection('products')
  //       // .where('uploaded_by', isEqualTo: user.email)
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((element) {
  //       print('The console says:\t${element['name']}');
  //       data = element['name'].toString();
  //     });
  //   });
  //   return data;
  // }
  // return _reference;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
