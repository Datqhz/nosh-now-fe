class GetRestaurantsByCategoryRequest {
  String categoryId;
  int pageNumber;
  int maxPerPage;
  String coordinate;
  GetRestaurantsByCategoryRequest({
      required this.categoryId,
      required this.pageNumber,
      required this.maxPerPage,
      required this.coordinate,
    });
  
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'pageNumber': pageNumber,
      'maxPerPage': maxPerPage,
      'coordinate': coordinate
    };
  }
}

