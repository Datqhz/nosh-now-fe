import 'package:nosh_now_application/data/responses/error_response.dart';

class GetCategoriesResponse extends ErrorResponse {

  List<GetCategoriesData>? data;
  GetCategoriesResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data
  });

  factory GetCategoriesResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetCategoriesResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? (json['data'] as List).map((e) => GetCategoriesData.fromJson(e)).toList(): null,
    );
  }
}


class GetCategoriesData{
  String categoryId;
  String categoryName;
  String categoryImage;
  
  GetCategoriesData({
    required this.categoryId, 
    required this.categoryName,
    required this.categoryImage
  });

  factory GetCategoriesData.fromJson(Map<dynamic, dynamic> json) {
    return GetCategoriesData(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryImage: json['categoryImage']
    );
  }
}
