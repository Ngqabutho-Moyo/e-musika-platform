import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTile extends StatefulWidget {
  const MapTile({super.key});

  @override
  State<MapTile> createState() => _MapTileState();
}

class _MapTileState extends State<MapTile> with SingleTickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(37.42796133580664, -122.885749655962),
    zoom: 14.4746,
  );
  final List<Marker> _list = const [Marker(markerId: MarkerId('1'))];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
