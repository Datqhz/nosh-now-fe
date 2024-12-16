class UpdateCategoryRequest {
  
  String categoryId;
  String categoryName;
  String image;

  UpdateCategoryRequest({
    required this.categoryId,
    required this.categoryName,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'image': image
    };
  }
}
