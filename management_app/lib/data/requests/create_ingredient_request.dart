import 'package:management_app/data/models/ingredient_unit.dart';

class CreateIngredientRequest {
  String ingredientName;
  String image;
  double quantity;
  IngredientUnit unit;
  
  CreateIngredientRequest({
    required this.ingredientName,
    required this.image,
    required this.quantity,
    required this.unit
  });

  Map<String, dynamic> toJson() {
    return {
      'ingredientName': ingredientName,
      'image': image,
      'quantity': quantity,
      'unit': unit.index + 1
    };
  }
}