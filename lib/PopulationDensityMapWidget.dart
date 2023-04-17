import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'PopulationDensityService.dart';

class PopulationDensityMapWidget extends StatefulWidget {
  @override
  _PopulationDensityMapWidgetState createState() =>
      _PopulationDensityMapWidgetState();
}

class _PopulationDensityMapWidgetState
    extends State<PopulationDensityMapWidget> {
  final PopulationDensityService service = PopulationDensityService();
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-33.92749771637825, 18.426668632624313),
    zoom: 5,
  );

  late int _populationDensity = 0;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    final LatLng location = LatLng(-33.92749771637825, 18.426668632624313);

    service.getPopulationDensity(location).then((value) {
      setState(() {
        _populationDensity = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
            initialCameraPosition: _initialPosition,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: _populationDensity == null
                ? CircularProgressIndicator()
                : Text(
              'Population density: $_populationDensity',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}