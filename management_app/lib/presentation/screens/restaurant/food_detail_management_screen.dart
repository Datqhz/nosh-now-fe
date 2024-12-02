import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:management_app/data/models/food_data.dart';
import 'package:management_app/data/providers/food_list_provider.dart';
import 'package:management_app/data/repositories/food_repository.dart';
import 'package:management_app/presentation/screens/restaurant/modify_food_screen.dart';

import 'package:provider/provider.dart';

class FoodDetailManagementScreen extends StatelessWidget {
  FoodDetailManagementScreen({
    super.key,
    required this.foodId,
  });

  int foodId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Consumer<FoodListProvider>(builder: (context, provider, child) {
          return FutureBuilder(
              future: FoodRepository().getFoodById(foodId, context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  var foodData = snapshot.data!;
                  return Stack(
                    children: [
                      // food image
                      Column(
                        children: [
                          Image(
                            image: NetworkImage(foodData.foodImage),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2.4,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1.7,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(240, 240, 240, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 32,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      foodData.foodName,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w800,
                                        height: 1.2,
                                        color: Color.fromRGBO(49, 49, 49, 1),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'vi_VN', symbol: '₫')
                                        .format(foodData.foodPrice),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w800,
                                      height: 1.2,
                                      color: Color.fromRGBO(49, 49, 49, 1),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Expanded(
                                child: Text(
                                  foodData.foodDescription,
                                  textAlign: TextAlign.left,
                                  maxLines: 10,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                    color: Color.fromRGBO(49, 49, 49, 1),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // App bar
                      Positioned(
                        top: 20,
                        left: 20,
                        right: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Icon(
                                  CupertinoIcons.arrow_left,
                                  color: Colors.black,
                                  size: 22,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Icon(
                                  CupertinoIcons.ellipsis_vertical,
                                  color: Colors.black,
                                  size: 22,
                                ),
                              ),
                              color: Colors.white,
                              onSelected: (value) async {
                                if (value == 'Update') {
                                  FoodData? newData = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ModifyFoodScreen(
                                                  food: snapshot.data)));
                                  if (newData != null) {
                                    Provider.of<FoodListProvider>(context,
                                            listen: false)
                                        .updateFood(newData.foodId, newData);
                                  }
                                } else if (value == 'Delete') {
                                  bool rs = await FoodRepository()
                                      .deleteFood(foodData.foodId, context);
                                  if (rs) {
                                    Provider.of<FoodListProvider>(context,
                                            listen: false)
                                        .deleteFood(foodData.foodId);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return {'Update', 'Delete'}
                                    .map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(
                                      choice,
                                      style: TextStyle(
                                          color: choice == 'Delete'
                                              ? Colors.red
                                              : Colors.black),
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ],
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
    );
  }
}
