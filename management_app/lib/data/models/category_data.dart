class CategoryData{
  String categoryId;
  String categoryName;
  String categoryImage;
  
  CategoryData({
    required this.categoryId, 
    required this.categoryName,
    required this.categoryImage
  });

  factory CategoryData.fromJson(Map<dynamic, dynamic> json) {
    return CategoryData(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryImage: json['categoryImage']
    );
  }
}