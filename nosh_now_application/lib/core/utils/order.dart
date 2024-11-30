import 'package:flutter/material.dart';
import 'package:nosh_now_application/data/models/order_detail.dart';

double calcSubtantial(List<OrderDetail> details) {
  double total = 0;
  for (var detail in details) {
    total += detail.price * detail.quantity;
  }
  return total;
}

double calcTotalPay(List<OrderDetail> details, double shipmentFee) {
  return calcSubtantial(details) + shipmentFee;
}

Color pickColorForStatus(int step) {
  if (step == 1) {
    return Colors.red; // checkout
  } else if (step == 2) {
    return Colors.orange;
  } else if (step == 3) {
    return Colors.blue;
  } else if (step == 4) {
    return Colors.green;
  } else {
    return Colors.grey;
  }
}
