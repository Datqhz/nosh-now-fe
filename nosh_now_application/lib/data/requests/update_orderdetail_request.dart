class UpdateOrderDetailRequest {
  int orderDetailId;
  int amount;

  UpdateOrderDetailRequest({
    required this.orderDetailId,
    required this.amount
  });

  Map<String, dynamic> toJson() {
    return {
      'orderDetailId': orderDetailId,
      'amount': amount
    };
  }
}