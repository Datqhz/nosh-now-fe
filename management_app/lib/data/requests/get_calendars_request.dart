class GetCalendarsRequest {
  DateTime fromDate;
  DateTime toDate;
  GetCalendarsRequest({required this.fromDate, required this.toDate});

  Map<String, dynamic> toJson() {
    return {
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }
}
