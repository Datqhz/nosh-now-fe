import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nosh_now_application/core/streams/order_detail_notifier.dart';
import 'package:nosh_now_application/core/utils/distance.dart';
import 'package:nosh_now_application/core/utils/map.dart';
import 'package:nosh_now_application/data/repositories/food_repository.dart';
import 'package:nosh_now_application/data/repositories/order_repository.dart';
import 'package:nosh_now_application/data/responses/get_food_by_restaurant_response.dart';
import 'package:nosh_now_application/data/responses/get_order_init_response.dart';
import 'package:nosh_now_application/data/responses/get_restaurants_response.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/food_detail_screen.dart';
import 'package:nosh_now_application/presentation/screens/main/eater/prepare_order_screen.dart';
import 'package:nosh_now_application/presentation/widgets/food_item.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RestaurantDetailScreen extends StatefulWidget {
  RestaurantDetailScreen({super.key, required this.restaurant});

  GetRestaurantsData restaurant;

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  ValueNotifier<GetOrderInitData?> order = ValueNotifier(null);
  ValueNotifier<List<GetFoodsData>> foods = ValueNotifier([]);
  ValueNotifier<List<OrderDetailData>> details = ValueNotifier([]);
  ValueNotifier<List<GlobalKey<FoodItemState>>> foodItemStates =
      ValueNotifier([]);

  Future<bool> _fetchAllData(BuildContext context) async {
    try {
      order.value = await OrderRepository()
          .getOrderInit(widget.restaurant.restaurantId, context);
      details.value = order.value!.orderDetails;
      foods.value = await FoodRepository()
          .getFoodByRestaurantId(widget.restaurant.restaurantId, context);
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  OrderDetailData? _checkHaveDetail(int foodId) {
    for (var detail in details.value) {
      if (detail.foodId == foodId) {
        return detail;
      }
    }
    return null;
  }

  bool checkDetailsIsEmpty(BuildContext context) {
    for (var i in foodItemStates.value) {
      int quantity = i.currentState!.getQuantity();
      print("quantity: $quantity");
      if (quantity != 0) {
        return false;
      }
    }
    return true;
  }

  List<Widget> buildListFood() {
    List<Widget> widgets = [];
    List<GlobalKey<FoodItemState>> states = [];
    for (var food in foods.value) {
      var key = GlobalKey<FoodItemState>();
      states.add(key);
      widgets.add(ChangeNotifierProvider(
        create: (context) {
          OrderDetailNotifier notifier = OrderDetailNotifier();
          notifier.init(_checkHaveDetail(food.foodId));
          return notifier;
        },
        child: Consumer<OrderDetailNotifier>(
          builder: (context, notifier, child) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailScreen(
                      foodId: food.foodId,
                      notifier: notifier,
                      orderId: order.value!.orderId,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: FoodItem(
                  key: key,
                  food: food,
                  detailNotifier: notifier,
                ),
              ),
            );
          },
        ),
      ));
    }
    foodItemStates.value = states;
    return widgets;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // merchant avatar
                    Image(
                      image: NetworkImage(widget.restaurant.avatar),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width - 40,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(240, 240, 240, 1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color.fromRGBO(159, 159, 159, 1),
                              width: 0.4)),
                      transform: Matrix4.translationValues(0, -70, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // merchant name
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 54,
                            child: Text(
                              widget.restaurant.restaurantName,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 54,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(159, 159, 159, 1),
                                  ),
                                  top: BorderSide(
                                    color: Color.fromRGBO(159, 159, 159, 1),
                                  )),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_sharp,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                //address
                                Expanded(
                                  child: FutureBuilder(
                                      future: getAddressFromLatLng(
                                          splitCoordinatorString(
                                              widget.restaurant.coordinate)),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData) {
                                          return Text(
                                            snapshot.data!,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Color.fromRGBO(49, 49, 49, 1),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 54,
                            child: Row(
                              children: [
                                // distance to merchant
                                Text(
                                  '${double.parse((widget.restaurant.distance).toStringAsFixed(2))} km',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(
                                  CupertinoIcons.circle_fill,
                                  size: 4,
                                  color: Color.fromRGBO(49, 49, 49, 1),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: _fetchAllData(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GridView.count(
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 2,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.9,
                                  children: buildListFood()),
                            );
                          } else {
                            return const Center(
                                child: SpinKitCircle(
                              color: Colors.black,
                              size: 40,
                            ));
                          }
                        }),
                  ],
                ),
              ),
            ),
            // App bar
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),
            ),
            // preview order
            Positioned(
              bottom: 80,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  if (order.value != null && !checkDetailsIsEmpty(context)) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrepareOrderScreen(orderId: order.value!.orderId))); 
                  }
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    CupertinoIcons.news,
                    color: Colors.white,
                    size: 30,
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
