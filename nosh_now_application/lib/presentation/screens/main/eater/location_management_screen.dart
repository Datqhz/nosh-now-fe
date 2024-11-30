import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nosh_now_application/core/streams/change_stream.dart';
import 'package:nosh_now_application/data/repositories/location_repository.dart';
import 'package:nosh_now_application/presentation/screens/main/pick_location_from_map.dart';
import 'package:nosh_now_application/presentation/widgets/location_management_item.dart';

class LocationManagementScreen extends StatefulWidget {
  const LocationManagementScreen({super.key});

  @override
  State<LocationManagementScreen> createState() =>
      _LocationManagementScreenState();
}

class _LocationManagementScreenState extends State<LocationManagementScreen> {
  ChangeStream notifier = ChangeStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: StreamBuilder(
                      stream: notifier.stream,
                      builder: (context, snapshot) {
                        return FutureBuilder(
                            future: LocationRepository().getSavedLocations(context),  // user id = GlobalVariable.currentUid
                            builder: (context, futureSnapshot) {
                              if (futureSnapshot.connectionState ==
                                      ConnectionState.done &&
                                  futureSnapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 66,
                                    ),
                                    ...List.generate(
                                      futureSnapshot.data!.length,
                                      (index) => LocationManagementItem(
                                        location: futureSnapshot.data![index],
                                        notifier: notifier,
                                      ),
                                    )
                                  ],
                                );
                              }
                              return const Center(
                                child: SpinKitCircle(
                                  color: Colors.black,
                                  size: 50,
                                ),
                              );
                            });
                      }),
                ),
              ),
              //app bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'Saved locations',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(49, 49, 49, 1),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),
              // pick from map
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PickLocationFromMapScreen(
                                  notifier: notifier,
                                )));
                  },
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Color.fromRGBO(159, 159, 159, 1))),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          )),
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.map,
                            size: 18,
                            color: Color.fromRGBO(49, 49, 49, 1),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Pick from map',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(49, 49, 49, 1),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
