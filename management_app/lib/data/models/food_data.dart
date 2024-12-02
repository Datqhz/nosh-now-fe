class FoodData{
  int foodId;
  String foodName;
  String foodImage;
  double price;
  
  FoodData({
    required this.foodId, 
    required this.foodName,
    required this.foodImage,
    required this.price
  });

  factory FoodData.fromJson(Map<dynamic, dynamic> json) {
    return FoodData(
      foodId: json['foodId'],
      foodName: json['foodName'],
      foodImage: json['foodImage'],
      price: json['price']
    );
  }
}