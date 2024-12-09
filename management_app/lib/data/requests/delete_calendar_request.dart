class DeleteCalendarsRequest {
  
  List<int> ids;
  
  DeleteCalendarsRequest({
    required this.ids
  });

  Map<String, dynamic> toJson() {
    return {
      'ids': ids
    };
  }
}