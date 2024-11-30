import 'package:nosh_now_application/data/models/delivery_info.dart';

class CheckoutOrderRequest {
  int orderId;
  String paymentMethod;
  double shippingFee;
  DeliveryInfo deliveryInfo;

  CheckoutOrderRequest({
    required this.orderId,
    required this.paymentMethod,
    required this.shippingFee,
    required this.deliveryInfo
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'paymentMethod': paymentMethod,
      'shippingFee': shippingFee,
      'deliveryInfo': deliveryInfo.toJson()
    };
  }
}
