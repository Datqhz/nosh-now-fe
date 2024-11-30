import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:latlong2/latlong.dart';
import 'package:nosh_now_application/core/utils/map.dart';
import 'package:nosh_now_application/data/repositories/category_repository.dart';
import 'package:nosh_now_application/data/repositories/restaurant_repository.dart';
import 'package:nosh_now_application/data/requests/get_restaurants_request.dart';
import 'package:nosh_now_application/data/responses/get_categories_response.dart';
import 'package:nosh_now_application/data/responses/get_restaurants_response.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/filter_merchant_by_category_screen.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/restaurant_detail_screen.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/search_food_restaurant_screen.dart';
import 'package:nosh_now_application/presentation/widgets/category_item.dart';
import 'package:nosh_now_application/presentation/widgets/merchant_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<GetCategoriesData>> _fetchCategoryData(
      BuildContext context) async {
    try {
      List<GetCategoriesData> categories =
          await CategoryRepository().getCategories(context);
      return categories;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<GetRestaurantsData>> _fetchRestaurants(
      BuildContext context) async {
    try {
      LatLng currentCoord = await checkPermissions();

      var request = new GetRestaurantsRequest(
          keyword: '',
          pageNumber: 1,
          maxPerPage: 10,
          coordinate: '${currentCoord.latitude}-${currentCoord.longitude}');

      List<GetRestaurantsData> merchants =
          await RestaurantRepository().getRestaurants(request, context);
      return merchants;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          color: const Color.fromRGBO(240, 240, 240, 1),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: const Text(
                    'Categories for you',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(49, 49, 49, 1)),
                  ),
                ),
                FutureBuilder(
                    future: _fetchCategoryData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return SizedBox(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FilterRestaurantByCategoryScreen(
                                                init: snapshot.data![index])));
                              },
                              child: CategoryItem(
                                category: snapshot.data![index],
                              ),
                            ),
                            itemCount: snapshot.data!.length,
                          ),
                        );
                      } else {
                        return const Center(
                          child: SpinKitCircle(
                            color: Colors.black,
                            size: 20,
                          ),
                        );
                      }
                    }),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: const Text(
                    'Some restaurants are near you',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(49, 49, 49, 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // list merchant
                ...[
                  FutureBuilder(
                      future: _fetchRestaurants(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Column(
                            children:
                                List.generate(snapshot.data!.length, (index) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RestaurantDetailScreen(
                                              restaurant:
                                                  snapshot.data![index]),
                                    ),
                                  ),
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: RestaurantItem(
                                    restaurant: snapshot.data![index],
                                  ),
                                ),
                              );
                            }),
                          );
                        } else {
                          return const Center(
                            child: SpinKitCircle(
                              color: Colors.black,
                              size: 40,
                            ),
                          );
                        }
                      })
                ],
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 50,
            color: const Color.fromRGBO(240, 240, 240, 1),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // drawer
                GestureDetector(
                  onTap: () {
                    // do something
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Icon(
                    CupertinoIcons.bars,
                    size: 22,
                    color: Color.fromRGBO(49, 49, 49, 1),
                  ),
                ),
                // search merchant
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SearchFoodAndRestaurantScreen()));
                  },
                  child: const Icon(
                    CupertinoIcons.search,
                    size: 22,
                    color: Color.fromRGBO(49, 49, 49, 1),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
