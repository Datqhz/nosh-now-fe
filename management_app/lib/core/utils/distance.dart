import 'dart:math';

import 'package:latlong2/latlong.dart';

double calcDistanceInKm(
    {double? lat1,
    double? lon1,
    double? lat2,
    double? lon2,
    String? coordinator1,
    String? coordinator2}) {
  const double R = 6371;
  if (coordinator1 != null && coordinator2 != null) {
    LatLng coord1 = splitCoordinatorString(coordinator1);
    LatLng coord2 = splitCoordinatorString(coordinator2);
    lat1 = coord1.latitude;
    lon1 = coord1.longitude;
    lat2 = coord2.latitude;
    lon2 = coord2.longitude;
  }
  double dLat = degreesToRadians(lat2! - lat1!);
  double dLon = degreesToRadians(lon2! - lon1!);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(degreesToRadians(lat1)) *
          cos(degreesToRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return double.parse((R * c).toStringAsFixed(2));
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

LatLng splitCoordinatorString(String coordinator) {
  var coords = coordinator.split('-');
  double lat = double.parse(coords[0].trim());
  double lon = double.parse(coords[1].trim());
  return LatLng(lat, lon);
}

double calculateTotalDistanceByRoute(List<LatLng> points) {
  double totalDistance = 0.0;
  final distance = Distance();

  for (int i = 0; i < points.length - 1; i++) {
    totalDistance += distance.as(LengthUnit.Kilometer, points[i], points[i + 1]);
  }

  return totalDistance;
}