import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:latlong2/latlong.dart';
import 'package:nosh_now_application/core/utils/map.dart';
import 'package:nosh_now_application/data/repositories/category_repository.dart';
import 'package:nosh_now_application/data/repositories/restaurant_repository.dart';
import 'package:nosh_now_application/data/requests/get_restaurant_by_category.dart';
import 'package:nosh_now_application/data/responses/get_categories_response.dart';
import 'package:nosh_now_application/data/responses/get_restaurants_response.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/restaurant_detail_screen.dart';
import 'package:nosh_now_application/presentation/widgets/category_item.dart';
import 'package:nosh_now_application/presentation/widgets/merchant_item.dart';

class FilterRestaurantByCategoryScreen extends StatefulWidget {
  const FilterRestaurantByCategoryScreen({super.key, this.init});

  final GetCategoriesData? init;

  @override
  State<FilterRestaurantByCategoryScreen> createState() =>
      _FilterRestaurantByCategoryScreenState();
}

class _FilterRestaurantByCategoryScreenState
    extends State<FilterRestaurantByCategoryScreen> {
  ValueNotifier<List<GetRestaurantsData>> restaurants = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  late ValueNotifier<GetCategoriesData?> categorySelected;
  @override
  void initState() {
    super.initState();
    categorySelected = ValueNotifier(widget.init);
    var request = GetRestaurantsByCategoryRequest(
        categoryId: categorySelected.value!.categoryId,
        pageNumber: 1,
        maxPerPage: 10,
        coordinate: '');
    _fetchRestaurants(request, context);
  }

  Future<List<GetCategoriesData>> _fetchCategories(BuildContext context) async {
    try {
      List<GetCategoriesData> categories =
          await CategoryRepository().getCategories(context);
      return categories;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void>_fetchRestaurants(
      GetRestaurantsByCategoryRequest request, BuildContext context) async {
    try {
      isLoading.value = true;
      LatLng currentCoordinate = await checkPermissions();
      request.coordinate =
          '${currentCoordinate.latitude}-${currentCoordinate.longitude}';
      restaurants.value = await RestaurantRepository().getRestaurantsByCategory(request, context);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                    const Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(49, 49, 49, 1)),
                    ),
                    FutureBuilder(
                        future: _fetchCategories(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return SizedBox(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () async {
                                    categorySelected.value = snapshot.data![index];
                                    restaurants.value = [];
                                    var request =
                                        GetRestaurantsByCategoryRequest(
                                            categoryId: categorySelected
                                                .value!.categoryId,
                                            pageNumber: 1,
                                            maxPerPage: 10,
                                            coordinate: '');
                                    await _fetchRestaurants(request, context);
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
                    ValueListenableBuilder(
                        valueListenable: categorySelected,
                        builder: (context, value, child) {
                          if (value != null) {
                            return Text(
                              '${value.categoryName}',
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
                          }
                          return const SizedBox();
                        }),
                    ValueListenableBuilder(
                      valueListenable: restaurants,
                      builder: (context, value, child) {
                        return Column(
                          children: List.generate(
                            value.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RestaurantDetailScreen(
                                              restaurant: value[index]),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child:
                                      RestaurantItem(restaurant: value[index]),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
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
                  color: const Color.fromRGBO(240, 240, 240, 1),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Row(
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
                          const Text(
                            'Filter restaurant',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(49, 49, 49, 1)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
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
