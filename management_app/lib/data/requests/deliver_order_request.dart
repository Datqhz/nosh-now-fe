class DeliverOrderRequest {
  int orderId;
  String proof;
  
  DeliverOrderRequest({
    required this.orderId,
    required this.proof
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'proof': proof
    };
  }
}
