import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosh_now_application/core/streams/change_stream.dart';
import 'package:nosh_now_application/core/utils/dialog.dart';
import 'package:nosh_now_application/core/utils/distance.dart';
import 'package:nosh_now_application/core/utils/map.dart';
import 'package:nosh_now_application/data/repositories/location_repository.dart';
import 'package:nosh_now_application/data/responses/get_saved_locations_response.dart';
import 'package:nosh_now_application/presentation/screens/main/pick_location_from_map.dart';

class LocationManagementItem extends StatelessWidget {
  LocationManagementItem(
      {super.key, required this.location, required this.notifier});

  GetSavedLocationData location;
  ChangeStream notifier;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: notifier.stream,
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.only(bottom: 8, top: 12),
            width: MediaQuery.of(context).size.width - 40,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(159, 159, 159, 1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(240, 240, 240, 0.8),
                      borderRadius: BorderRadius.circular(50)),
                  alignment: Alignment.center,
                  child: const Icon(
                    CupertinoIcons.clock_fill,
                    color: Colors.blue,
                    size: 16,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // location - phone
                      Text(
                        '${location.name} - ${location.phone}',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      FutureBuilder(
                          future: getAddressFromLatLng(
                              splitCoordinatorString(location.coordinate)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w300,
                                  height: 1.2,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }
                            return const Text(
                              '',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w300,
                                height: 1.2,
                                color: Color.fromRGBO(49, 49, 49, 1),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          })
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PickLocationFromMapScreen(
                                      location: location,
                                      notifier: notifier,
                                    )));
                      },
                      child: const Icon(
                        CupertinoIcons.pencil,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () => showDeleteDialog(
                          context, 'location', location.name, () async {
                        var rs = await LocationRepository()
                            .deleteSavedLocation(location.id, context);
                        if (rs) {
                          Navigator.pop(context);
                          notifier.notifyChange();
                        }
                      }),
                      child: const Icon(
                        CupertinoIcons.trash,
                        color: Colors.red,
                        size: 24,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
