
class UpdateStatusOrderdetailRequest {
  int orderId;
  List<UpdateStatusOrderdetailInput> input;

  UpdateStatusOrderdetailRequest({
    required this.orderId,
    required this.input
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'input': input.map((e)=> e.toJson()).toList()
    };
  }
}

class UpdateStatusOrderdetailInput {
  int orderDetailId;
  int status;

  UpdateStatusOrderdetailInput({
    required this.orderDetailId,
    required this.status
  });

  Map<String, dynamic> toJson() {
    return {
      'orderDetailId': orderDetailId,
      'status': status
    };
  }
}
