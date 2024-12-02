class CreateFoodRequest {
  String foodName;
  String foodImage;
  double foodPrice;
  String foodDescription;
  String categoryId;
  List<RequiredIngredient> ingredients;
  
  CreateFoodRequest({
    required this.foodName,
    required this.foodImage,
    required this.foodPrice,
    required this.foodDescription,
    required this.categoryId,
    required this.ingredients
  });

  Map<String, dynamic> toJson() {
    return {
      'foodName': foodName,
      'foodImage': foodImage,
      'foodPrice': foodPrice,
      'foodDescription': foodDescription,
      'categoryId': categoryId,
      'ingredients': ingredients.map((x) => x.toJson()).toList(),
    };
  }
}

class RequiredIngredient {
  int ingredientId;
  double quantity;
  
  RequiredIngredient({
    required this.ingredientId,
    required this.quantity
  });

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'quantity': quantity
    };
  }
}