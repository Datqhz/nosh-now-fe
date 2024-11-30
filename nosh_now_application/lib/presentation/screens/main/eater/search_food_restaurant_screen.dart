import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:latlong2/latlong.dart';
import 'package:nosh_now_application/core/utils/map.dart';
import 'package:nosh_now_application/data/repositories/restaurant_repository.dart';
import 'package:nosh_now_application/data/requests/get_restaurants_request.dart';
import 'package:nosh_now_application/data/responses/get_restaurants_response.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/restaurant_detail_screen.dart';
import 'package:nosh_now_application/presentation/widgets/merchant_item.dart';

class SearchFoodAndRestaurantScreen extends StatefulWidget {
  const SearchFoodAndRestaurantScreen({
    super.key,
  });

  @override
  State<SearchFoodAndRestaurantScreen> createState() =>
      _SearchFoodAndRestaurantScreenState();
}

class _SearchFoodAndRestaurantScreenState
    extends State<SearchFoodAndRestaurantScreen> {
  final TextEditingController _controller = TextEditingController();
  ValueNotifier<List<GetRestaurantsData>> restaurants = ValueNotifier([]);
  late ValueNotifier<bool> isLoading = ValueNotifier(false);
  late ValueNotifier<String> regex = ValueNotifier("");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ValueListenableBuilder(
                        valueListenable: regex,
                        builder: (context, value, child) {
                          return Text(
                            "Search '$value'",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                              color: Color.fromRGBO(49, 49, 49, 1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    ValueListenableBuilder(
                        valueListenable: restaurants,
                        builder: (context, value, child) {
                          if (value.isEmpty && isLoading.value == false) {
                            return Text(
                              "Don't have any restaurant has name contain '${regex.value}'",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                height: 1.2,
                                color: Color.fromRGBO(49, 49, 49, 1),
                              ),
                            );
                          }
                          return Column(
                            children: List.generate(value.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantDetailScreen(
                                                  restaurant: value[index])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child:
                                      RestaurantItem(restaurant: value[index]),
                                ),
                              );
                            }),
                          );
                        }),
                    ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, value, child) {
                          if (value) {
                            return const Center(
                              child: SpinKitCircle(
                                color: Colors.black,
                                size: 50,
                              ),
                            );
                          }
                          return const SizedBox();
                        })
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromRGBO(240, 240, 240, 1),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        height: 40,
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  isLoading.value = true;
                                  restaurants.value = [];
                                  var currentRegex = _controller.text.trim();
                                  regex.value = currentRegex;
                                  LatLng currentCoord =
                                      await checkPermissions();

                                  var request = new GetRestaurantsRequest(
                                      keyword: currentRegex,
                                      pageNumber: 1,
                                      maxPerPage: 10,
                                      coordinate:
                                          '${currentCoord.latitude}-${currentCoord.longitude}');

                                  restaurants.value =
                                      await RestaurantRepository()
                                          .getRestaurants(request, context);
                                  isLoading.value = false;
                                },
                                icon: const Icon(
                                  CupertinoIcons.search,
                                  color: Colors.black,
                                  size: 20,
                                )),
                            hintText: "ex. Pho 10, abc,...",
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(159, 159, 159, 1)),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(35, 35, 35, 1),
                                width: 1,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                              color: Color.fromRGBO(49, 49, 49, 1),
                              fontSize: 14,
                              decoration: TextDecoration.none),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
