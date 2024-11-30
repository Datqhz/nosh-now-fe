import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nosh_now_application/core/utils/distance.dart';
import 'package:nosh_now_application/core/utils/map.dart';
import 'package:nosh_now_application/data/repositories/location_repository.dart';
import 'package:nosh_now_application/data/responses/get_saved_locations_response.dart';
import 'package:nosh_now_application/presentation/screens/main/pick_location_from_map.dart';
import 'package:nosh_now_application/presentation/widgets/saved_location.dart';

class PickLocationScreen extends StatefulWidget {
  PickLocationScreen({super.key, required this.currentPick});

  GetSavedLocationData currentPick;

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 66,
                      ),
                      // current delivery infomation
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(240, 240, 240, 0.8),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              CupertinoIcons.scope,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          //current pick
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.currentPick.name} - ${widget.currentPick.phone}',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis),
                              ),
                              FutureBuilder(
                                  future: getAddressFromLatLng(
                                      splitCoordinatorString(
                                          widget.currentPick.coordinate)),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(49, 49, 49, 1),
                                            overflow: TextOverflow.ellipsis),
                                      );
                                    }
                                    return const SizedBox();
                                  }),
                            ],
                          ),
                          const Expanded(
                              child: SizedBox(
                            width: 12,
                          )),
                          const Icon(
                            Icons.chevron_right,
                            color: Color.fromRGBO(49, 49, 49, 1),
                            size: 30,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(159, 159, 159, 1)))),
                      ),

                      const SizedBox(
                        height: 12,
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
                      FutureBuilder(
                          future: LocationRepository().getSavedLocations(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                              return Column(
                                children: List.generate(snapshot.data!.length,
                                    (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (snapshot.data![index].id != widget.currentPick.id) {
                                        Navigator.pop(context, snapshot.data![index]);
                                      }
                                    },
                                    child: SavedLocation(
                                      location: snapshot.data![index],
                                      isPicked:
                                          (snapshot.data![index].id == widget.currentPick.id),
                                    ),
                                  );
                                }),
                              );
                            }
                            return const Center(
                              child: SpinKitCircle(
                                color: Colors.black,
                                size: 50,
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 70,
                      )
                    ],
                  ),
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
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          CupertinoIcons.circle_filled,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Home',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16.0,
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
                  onTap: () async {
                    var newLocation = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PickLocationFromMapScreen()));
                    Navigator.pop(context, newLocation);
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
