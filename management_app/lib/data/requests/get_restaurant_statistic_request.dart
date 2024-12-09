class GetRestaurantStatisticRequest {
  DateTime fromDate;
  DateTime toDate;

  GetRestaurantStatisticRequest({
    required this.fromDate,
    required this.toDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }
}