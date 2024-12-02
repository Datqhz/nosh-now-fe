import 'package:flutter/material.dart';
import 'package:management_app/data/repositories/ingredient_repository.dart';
import 'package:management_app/data/responses/get_ingredients_response.dart';

class IngredientListProvider with ChangeNotifier {
  List<GetIngredientsData> _ingredient = [];
  bool _isLoading = true;

  List<GetIngredientsData> get ingredients => _ingredient;
  bool get isLoading => _isLoading;

  void updateIngredient(int id, GetIngredientsData newIngredient) {
    final index = _ingredient.indexWhere((ingredient) => ingredient.id == id);
    if (index != -1) {
      _ingredient[index].name = newIngredient.name;
      _ingredient[index].image = newIngredient.image;
      _ingredient[index].quantity = newIngredient.quantity;
      notifyListeners();
    }
  }

  void deleteIngredient(int id) {
    final index = _ingredient.indexWhere((ingredient) => ingredient.id == id);
    if (index != -1) {
      _ingredient.removeAt(index);
      notifyListeners();
    }
  }

  void addIngredient(GetIngredientsData ingredient) {
    _ingredient.add(ingredient);
    notifyListeners();
  }

  Future<void> fetchIngredients(BuildContext context) async {
    try {
      List<GetIngredientsData> ingredients =
          await IngredientRepository().getIngredients(context);
      _ingredient = ingredients;
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
