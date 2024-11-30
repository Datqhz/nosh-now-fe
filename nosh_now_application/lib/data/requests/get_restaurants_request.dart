class GetRestaurantsRequest {
  String keyword;
  int pageNumber;
  int maxPerPage;
  String coordinate;
  GetRestaurantsRequest({
      required this.keyword,
      required this.pageNumber,
      required this.maxPerPage,
      required this.coordinate,
    });
  
  Map<String, dynamic> toJson() {
    return {
      'keyword': keyword,
      'pageNumber': pageNumber,
      'maxPerPage': maxPerPage,
      'coordinate': coordinate
    };
  }
}

