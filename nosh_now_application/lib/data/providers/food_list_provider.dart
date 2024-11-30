import 'package:flutter/foundation.dart';
import 'package:nosh_now_application/data/models/food.dart';

class FoodListProvider with ChangeNotifier {
  List<Food> _foods = [];
  List<Food> _tempFoods = [];
  bool _isLoading = true;

  List<Food> get foods => _foods;
  bool get isLoading => _isLoading;

  void updateFood(int id, Food newFood) {
    final index = _foods.indexWhere((food) => food.foodId == id);
    final tempIdx = _tempFoods.indexWhere((food) => food.foodId == id);
    if (index != -1) {
      _foods[index].foodName = newFood.foodName;
      _foods[index].foodImage = newFood.foodImage;
      _foods[index].foodDescribe = newFood.foodDescribe;
      _foods[index].price = newFood.price;
      _foods[index].status = newFood.status;
      _tempFoods[tempIdx].foodName = newFood.foodName;
      _tempFoods[tempIdx].foodImage = newFood.foodImage;
      _tempFoods[tempIdx].foodDescribe = newFood.foodDescribe;
      _tempFoods[tempIdx].price = newFood.price;
      _tempFoods[tempIdx].status = newFood.status;
      notifyListeners(); 
    }
  }
  void deleteFood(int id) {
    final index = _foods.indexWhere((food) => food.foodId == id);
    final tempIdx = _tempFoods.indexWhere((food) => food.foodId == id);
    if (index != -1) {
      _foods.removeAt(index);
      _tempFoods.removeAt(tempIdx);
      notifyListeners(); 
    }
  }
  void addFood(Food food) {
      _foods.add(food);
      _tempFoods.add(food);
      notifyListeners(); 
    }
  void filterFoodByName(String regex){
      List<Food> afterFilter = [];
      for(var item in _tempFoods){
        if(item.foodName.contains(regex)){
          afterFilter.add(item);
        }
      }
      _foods = afterFilter;
      notifyListeners();
    }

  Future<void> fetchFoods(int merchantId) async {
    try {
      // List<Food> foods = await FoodRepository().getAllByMerchant(merchantId);
      _foods = foods;
      _tempFoods = foods;
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
}
