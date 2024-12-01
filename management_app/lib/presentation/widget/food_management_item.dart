import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_app/core/utils/dialog.dart';
import 'package:management_app/data/models/food_data.dart';
import 'package:management_app/data/providers/food_list_provider.dart';
import 'package:management_app/data/repositories/food_repository.dart';
import 'package:management_app/presentation/screens/restaurant/food_detail_management_screen.dart';
import 'package:management_app/presentation/screens/restaurant/modify_food_screen.dart';
import 'package:provider/provider.dart';

class FoodManagementItem extends StatelessWidget {
  FoodManagementItem({super.key, required this.food});

  FoodData food;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(bottom: 8, top: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(159, 159, 159, 1),
            width: 1,
          ),
        ),
      ),
      child: Row(children: [
        // food image
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FoodDetailManagementScreen(foodId: food.foodId)));
            },
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(food.foodImage), fit: BoxFit.cover),
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
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
                      // food name
                      Text(
                        food.foodName,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(food.price),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          height: 1.2,
                          color: Color.fromRGBO(49, 49, 49, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                 var foodData = await FoodRepository().getFoodById(food.foodId, context);
                FoodData? updateData = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ModifyFoodScreen(food: foodData)));
                if (updateData != null) {
                  Provider.of<FoodListProvider>(context, listen: false)
                      .updateFood(updateData.foodId, updateData);
                }
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
              onTap: () async {
                showDeleteDialog(
                  context,
                  'food',
                  food.foodName,
                  () async {
                    bool rs = await FoodRepository().deleteFood(food.foodId, context);
                    if (rs) {
                      Provider.of<FoodListProvider>(context, listen: false)
                          .deleteFood(food.foodId);
                      Navigator.pop(context);
                    }
                  },
                );
              },
              child: const Icon(
                CupertinoIcons.trash,
                color: Colors.red,
                size: 24,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
