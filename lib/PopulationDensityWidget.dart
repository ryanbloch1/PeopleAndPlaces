import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'PopulationDensityService.dart';

class PopulationDensityWidget extends StatelessWidget {
  final PopulationDensityService service = PopulationDensityService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: service.getPopulationDensity(LatLng(-33.91869962232099, 18.421459774624964)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('Population density: ${snapshot.data}');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
