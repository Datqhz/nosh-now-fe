import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nosh_now_application/core/streams/change_stream.dart';
import 'package:nosh_now_application/core/utils/distance.dart';
import 'package:nosh_now_application/core/utils/map.dart';
import 'package:nosh_now_application/core/utils/snack_bar.dart';
import 'package:nosh_now_application/data/models/location.dart';
import 'package:nosh_now_application/data/repositories/location_repository.dart';
import 'package:nosh_now_application/data/responses/get_saved_locations_response.dart';

class PickLocationFromMapScreen extends StatefulWidget {
  PickLocationFromMapScreen({super.key, this.location, this.notifier});

  GetSavedLocationData? location;
  ChangeStream? notifier;

  @override
  _PickLocationFromMapScreenState createState() =>
      _PickLocationFromMapScreenState();
}

class _PickLocationFromMapScreenState extends State<PickLocationFromMapScreen> {
  MapController mapController = MapController();
  ValueNotifier<List<LatLng>> routeCoordinates = ValueNotifier([]);
  late ValueNotifier<LatLng> marker;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    if (widget.location != null) {
      dynamic coord = splitCoordinatorString(widget.location!.coordinate);
      marker = ValueNotifier(coord);
      _nameController.text = widget.location!.name;
      _phoneController.text = widget.location!.phone;
    } else {
      marker = ValueNotifier(const LatLng(0, 0));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              future: checkPermissions(),
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
                        ValueListenableBuilder(
                            valueListenable: marker,
                            builder: (context, value, chid) {
                              return MarkerLayer(
                                rotate: true,
                                markers: [
                                  Marker(
                                    point: value,
                                    child: GestureDetector(
                                      onTap: () {
                                        marker.value = const LatLng(0, 0);
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
                                            color: Colors.black, width: 0.2),
                                        borderRadius: BorderRadius.circular(50),
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
                            })
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
                    LatLng latLng = await checkPermissions();
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
                        if (marker.value.latitude == 0 &&
                            marker.value.longitude == 0) {
                          showSnackBar(context, "Please choose location");
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          String locationName = _nameController.text.trim();
                          String phone = _phoneController.text.trim();
                          Location? rs = null;
                          if (widget.location != null) {
                            // rs = await LocationRepository().update(location);
                          } else {
                            // rs = await LocationRepository()
                            //     .create(location, 1);
                          }
                          if (rs != null) {
                            if (widget.notifier != null) {
                              widget.notifier!.notifyChange();
                            }
                            Navigator.pop(context, rs);
                          }
                        }
                      },
                      child: const Icon(
                        Icons.save,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
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
                                          return const Expanded(
                                            child: Text(
                                              'Choose your location',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      49, 49, 49, 1),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData) {
                                          return Expanded(
                                            child: Text(
                                              snapshot.data!,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      49, 49, 49, 1),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          );
                                        }
                                        return const Expanded(
                                          child: Text(
                                            'Choose your location',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    49, 49, 49, 1),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        );
                                      });
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Location name',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(55, 55, 55, 0.5),
                              fontWeight: FontWeight.w400),
                        ),
                        // location name input
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(118, 118, 118, 1),
                                  width: 1), // Màu viền khi không được chọn
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(35, 35, 35, 1),
                                width: 1,
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(182, 0, 0, 1),
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(182, 0, 0, 1),
                                width: 1,
                              ),
                            ),
                            errorStyle:
                                TextStyle(color: Color.fromRGBO(182, 0, 0, 1)),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                              color: Color.fromRGBO(49, 49, 49, 1),
                              fontSize: 14,
                              decoration: TextDecoration.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter location name.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Phone number',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(55, 55, 55, 0.5),
                              fontWeight: FontWeight.w400),
                        ),
                        // phone input
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(118, 118, 118, 1),
                                  width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(35, 35, 35, 1),
                                width: 1,
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(182, 0, 0, 1),
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(182, 0, 0, 1),
                                width: 1,
                              ),
                            ),
                            errorStyle:
                                TextStyle(color: Color.fromRGBO(182, 0, 0, 1)),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                              color: Color.fromRGBO(49, 49, 49, 1),
                              fontSize: 14,
                              decoration: TextDecoration.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your password.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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
