import 'package:flutter/material.dart';
import 'package:management_app/data/models/food_data.dart';
import 'package:management_app/data/repositories/food_repository.dart';

class FoodListProvider with ChangeNotifier {
  List<FoodData> _foods = [];
  bool _isLoading = true;

  List<FoodData> get foods => _foods;
  bool get isLoading => _isLoading;

  void updateFood(int id, FoodData newFood) {
    final index = _foods.indexWhere((food) => food.foodId == id);
    if (index != -1) {
      _foods[index].foodName = newFood.foodName;
      _foods[index].foodImage = newFood.foodImage;
      _foods[index].price = newFood.price;
      notifyListeners();
    }
  }

  void deleteFood(int id) {
    final index = _foods.indexWhere((food) => food.foodId == id);
    if (index != -1) {
      _foods.removeAt(index);
      notifyListeners();
    }
  }

  void addFood(FoodData food) {
    _foods.add(food);
    notifyListeners();
  }
  // void filterFoodByName(String regex){
  //     List<FoodData> afterFilter = [];
  //     for(var item in _tempFoods){
  //       if(item.foodName.contains(regex)){
  //         afterFilter.add(item);
  //       }
  //     }
  //     _foods = afterFilter;
  //     notifyListeners();
  //   }

  Future<void> fetchFoods(String restaurantId, BuildContext context) async {
    try {
      List<FoodData> foods =
          await FoodRepository().getFoodByRestaurantId(restaurantId, context);
      _foods = foods;
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
