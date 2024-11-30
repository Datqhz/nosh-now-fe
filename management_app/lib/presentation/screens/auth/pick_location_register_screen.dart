import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:management_app/core/utils/map.dart';
import 'package:permission_handler/permission_handler.dart';

class PickLocationRegisterScreen extends StatefulWidget {
  const PickLocationRegisterScreen({super.key});

  @override
  _PickLocationRegisterScreenState createState() =>
      _PickLocationRegisterScreenState();
}

class _PickLocationRegisterScreenState
    extends State<PickLocationRegisterScreen> {
  MapController mapController = MapController();
  ValueNotifier<List<LatLng>> routeCoordinates = ValueNotifier([]);
  ValueNotifier<LatLng> marker = ValueNotifier(const LatLng(0, 0));
  @override
  void initState() {
    super.initState();
  }

  Future<LatLng> _checkPermissions() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      if (await Permission.location.request().isGranted) {
        return await _getCurrentLocation();
      } else {
        throw Exception();
      }
    } else {
      return await _getCurrentLocation();
    }
  }

  Future<LatLng> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    await _loadRoute(LatLng(position.latitude, position.longitude),
        const LatLng(13.297841113632936, 109.06575986815542));
    return LatLng(position.latitude, position.longitude);
  }

  Future<void> _loadRoute(LatLng start, LatLng end) async {
    try {
      final coordinates = await getRouteCoordinates(start, end);
      routeCoordinates.value = coordinates;
    } catch (e) {
      ;
      print('Failed to load route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              future: _checkPermissions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                          initialCenter: snapshot.data!,
                          initialZoom: 16,
                          onTap: (_, latlng) {
                            marker.value = latlng;
                          }),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        FutureBuilder(
                            future: _getCurrentLocation(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return ValueListenableBuilder(
                                    valueListenable: marker,
                                    builder: (context, value, chid) {
                                      return MarkerLayer(
                                        rotate: true,
                                        markers: [
                                          Marker(
                                            point: value,
                                            child: GestureDetector(
                                              onTap: () {
                                                marker.value =
                                                    const LatLng(0, 0);
                                              },
                                              child: const Icon(
                                                Icons.location_pin,
                                                size: 30,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          Marker(
                                            height: 20,
                                            width: 20,
                                            point: snapshot.data!,
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 0.2),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: const Icon(
                                                Icons.circle,
                                                size: 18,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              }
                              return const SizedBox();
                            }),
                      ]);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            // move to current location
            Positioned(
                right: 20,
                top: 60,
                child: GestureDetector(
                  onTap: () async {
                    LatLng latLng = await _getCurrentLocation();
                    mapController.move(latLng, 16);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.location_searching_outlined)),
                )),
            // app bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // back
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        CupertinoIcons.arrow_left,
                        size: 24,
                        color: Color.fromRGBO(49, 49, 49, 1),
                      ),
                    ),
                    // save
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context, marker.value);
                      },
                      child: const Icon(
                        CupertinoIcons.check_mark,
                        size: 24,
                        color: Color.fromRGBO(49, 49, 49, 1),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // form
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Address: ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(55, 55, 55, 0.5),
                            fontWeight: FontWeight.w400),
                      ),
                      ValueListenableBuilder(
                          valueListenable: marker,
                          builder: (context, value, child) {
                            return FutureBuilder(
                                future: getAddressFromLatLng(value),
                                builder: (context, snapshot) {
                                  if (value.latitude == 0 &&
                                      value.longitude == 0) {
                                    return const Text(
                                      'Choose your location',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(49, 49, 49, 1),
                                          fontWeight: FontWeight.w400),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return Text(
                                      snapshot.data!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(49, 49, 49, 1),
                                          fontWeight: FontWeight.w400),
                                    );
                                  }
                                  return const Text(
                                    'Choose your location',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(49, 49, 49, 1),
                                        fontWeight: FontWeight.w400),
                                  );
                                });
                          }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
