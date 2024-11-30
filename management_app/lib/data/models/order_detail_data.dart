class OrderDetailData {
  int orderDetailId;
  String foodName;
  String foodImage;
  double foodPrice;
  int amount;

  OrderDetailData(
      {required this.orderDetailId,
      required this.foodName,
      required this.foodImage,
      required this.foodPrice,
      required this.amount});

  factory OrderDetailData.fromJson(Map<dynamic, dynamic> json) {
    return OrderDetailData(
        orderDetailId: json['orderDetailId'],
        foodName: json['foodName'],
        foodImage: json['foodImage'],
        foodPrice: json['foodPrice'] / 1.0,
        amount: json['amount']);
  }
}
