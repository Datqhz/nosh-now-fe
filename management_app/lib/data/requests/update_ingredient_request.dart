import 'package:management_app/data/models/ingredient_unit.dart';

class UpdateIngredientRequest {
  int ingredientId;
  String ingredientName;
  String image;
  double quantity;
  IngredientUnit unit;
  
  UpdateIngredientRequest({
    required this.ingredientId,
    required this.ingredientName,
    required this.image,
    required this.quantity,
    required this.unit
  });

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'ingredientName': ingredientName,
      'image': image,
      'quantity': quantity,
      'unit': unit.index
    };
  }
}