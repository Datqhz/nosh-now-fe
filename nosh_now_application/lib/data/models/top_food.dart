class TopFood{
  int foodId;
  String foodName;
  double revenue;
  TopFood({required this.foodId, required this.foodName, required this.revenue});
  factory TopFood.fromJson(Map<String, dynamic> json){
    return TopFood(foodId: json['foodId'], foodName: json['foodName'], revenue: json['revenue']/1.0);
  }
}