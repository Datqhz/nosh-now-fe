import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

Future<LatLng> checkPermissions() async {
  var status = await Permission.location.status;
  if (status.isDenied || status.isPermanentlyDenied) {
    if (await Permission.location.request().isGranted) {
      return await getCurrentCoordinator();
    } else {
      throw Exception();
    }
  } else {
    return await getCurrentCoordinator();
  }
}

Future<LatLng> getCurrentCoordinator() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return LatLng(position.latitude, position.longitude);
}

Future<List<LatLng>> getRouteCoordinates(LatLng start, LatLng end) async {
  final url =
      'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson';
  final response = await get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final coordinates = data['routes'][0]['geometry']['coordinates'];
    return coordinates
        .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
        .toList();
  } else {
    throw Exception('Failed to load route');
  }
}

Future<String> getAddressFromLatLng(LatLng latlng) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latlng.latitude, latlng.longitude);

    Placemark place = placemarks[0];
    var output = 'No results found.';
    if (placemarks.isNotEmpty) {
      output =
          "${place.street}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
    }
    return output;
  } catch (e) {
    print(e);
    throw Exception();
  }
}
