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

  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition initialPoint = CameraPosition(
      target: scanModel.getLatLng(),
      zoom: 16,
      tilt: 50,
    );

    //marcador
    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
        markerId: MarkerId('geo-location'), position: scanModel.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                await controller.animateCamera(
                    CameraUpdate.newCameraPosition(initialPoint));
              },
              icon: const Icon(Icons.location_searching))
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
          });
        },
        child: const Icon(
          Icons.layers,
          color: Colors.white,
        ),
      ),
    );
  }
}
