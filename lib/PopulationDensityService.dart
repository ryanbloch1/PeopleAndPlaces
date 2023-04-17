import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class PopulationDensityService {
  final apiKey = 'AIzaSyAU98u0pqUQojm1Nxxtg0RzOC6ZA08HLTQ';

  Future<int> getPopulationDensity(LatLng location) async {
    final url =
        'https://www.googleapis.com/geolocation/v1/geolocate?key=$apiKey';
    final httpResponse = await http.post(Uri.parse(url));

    if (httpResponse.statusCode == 200) {

      final body = json.decode(httpResponse.body);
      final latitude = body['location']['lat'];
      final longitude = body['location']['lng'];

      final url =
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=$apiKey&location=$latitude,$longitude&radius=500&type=store';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final results = body['results'];
        return results.length;
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
