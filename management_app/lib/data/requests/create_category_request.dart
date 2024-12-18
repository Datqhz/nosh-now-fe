class CreateCategoryRequest {

  String categoryName;
  String image;

  CreateCategoryRequest({
    required this.categoryName,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'image': image
    };
  }
}
