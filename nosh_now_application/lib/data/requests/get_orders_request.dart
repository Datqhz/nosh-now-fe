class GetOrdersRequest {
  int orderStatus;
  int sortDirection;

  GetOrdersRequest({required this.orderStatus, required this.sortDirection});

  Map<String, dynamic> toJson() {
    return {'orderStatus': orderStatus, 'sortDirection': sortDirection};
  }
}
