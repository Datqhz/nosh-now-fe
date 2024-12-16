import 'package:management_app/data/models/error_response.dart';

class GetFoodByIdResponse extends ErrorResponse {

  GetFoodByIdData? data;

  GetFoodByIdResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory GetFoodByIdResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetFoodByIdResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? GetFoodByIdData.fromJson(json['data']) : null,
    );
  }
}


// TODO: change foodDescription to required //
class GetFoodByIdData{
  int foodId;
  String foodName;
  String foodImage;
  double foodPrice;
  FoodCategoryData category;
  String foodDescription;
  List<FoodIngredientData> foodIngredients;
  
  GetFoodByIdData({
    required this.foodId, 
    required this.foodName,
    required this.foodImage,
    required this.foodPrice,
    required this.category,
    required this.foodDescription,
    required this.foodIngredients
  });

  factory GetFoodByIdData.fromJson(Map<dynamic, dynamic> json) {
    return GetFoodByIdData(
      foodId: json['foodId'],
      foodName: json['foodName'],
      foodImage: json['foodImage'],
      foodPrice: json['foodPrice'],
      category: FoodCategoryData.fromJson(json['category']),
      foodDescription: json['foodDescription'],
      foodIngredients: (json['foodIngredients'] as List).map((e) => FoodIngredientData.fromJson(e)).toList(),
    );
  }
}

class FoodIngredientData{
  int requiredIngredientId;
  int ingredientId;
  String ingredientName;
  String ingredientImage;
  double requiredAmount;
  String unit;
  
  FoodIngredientData({
    required this.requiredIngredientId, 
    required this.ingredientName,
    required this.ingredientImage,
    required this.requiredAmount,
    required this.unit,
    required this.ingredientId
  });

  factory FoodIngredientData.fromJson(Map<dynamic, dynamic> json) {
    return FoodIngredientData(
      requiredIngredientId: json['requiredIngredientId'],
      ingredientName: json['ingredientName'],
      ingredientImage: json['ingredientImage'],
      requiredAmount: json['requiredAmount'] / 1.0,
      unit: json['unit'],
      ingredientId: json['ingredientId']
    );
  }
}

class FoodCategoryData{
  String categoryId;
  String categoryName;

   FoodCategoryData({
    required this.categoryId, 
    required this.categoryName
  });

  factory FoodCategoryData.fromJson(Map<dynamic, dynamic> json) {
    return FoodCategoryData(
      categoryId: json['categoryId'],
      categoryName: json['categoryName']
    );
  }

}