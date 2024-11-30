class CreateOrderDetailRequest {
  int foodId;
  int orderId;
  int amount;

  CreateOrderDetailRequest({
    required this.foodId,
    required this.orderId,
    required this.amount
  });

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'orderId': orderId,
      'amount': amount
    };
  }
}