import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scanner_sqlite/models/scan_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition initialPoint = CameraPosition(
      target: scanModel.getLatLng(),
      zoom: 16,
      tilt: 50,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
