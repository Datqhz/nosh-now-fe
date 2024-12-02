class UpdateFoodRequest {
  int foodId;
  String foodName;
  String foodImage;
  double foodPrice;
  String foodDescription;
  String categoryId;
  List<ModifyRequiredIngredient> ingredients;
  
  UpdateFoodRequest({
    required this.foodId, 
    required this.foodName,
    required this.foodImage,
    required this.foodPrice,
    required this.foodDescription,
    required this.categoryId,
    required this.ingredients
  });

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'foodName': foodName,
      'foodImage': foodImage,
      'foodPrice': foodPrice,
      'foodDescription': foodDescription,
      'categoryId': categoryId,
      'ingredients': ingredients.map((x) => x.toJson()).toList(),
    };
  }
}

class ModifyRequiredIngredient {
  int requiredIngredientId;
  int ingredientId;
  double quantity;
  int modifyOption;
  
  ModifyRequiredIngredient({
    required this.requiredIngredientId, 
    required this.ingredientId,
    required this.quantity,
    required this.modifyOption,
  });

  Map<String, dynamic> toJson() {
    return {
      'requiredIngredientId': requiredIngredientId,
      'ingredientId': ingredientId,
      'quantity': quantity,
      'modifyOption': modifyOption,
    };
  }
}