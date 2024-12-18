import 'package:management_app/data/models/ingredient_unit.dart';
import 'package:management_app/data/responses/error_response.dart';

class GetIngredientsResponse extends ErrorResponse {
  List<GetIngredientsData>? data;
  GetIngredientsResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory GetIngredientsResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetIngredientsResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => GetIngredientsData.fromJson(e))
              .toList()
          : null,
    );
  }
}

class GetIngredientsData {
  int id;
  String name;
  String image;
  double quantity;
  IngredientUnit unit;

  GetIngredientsData(
      {required this.id,
      required this.name,
      required this.image,
      required this.quantity,
      required this.unit});

  factory GetIngredientsData.fromJson(Map<dynamic, dynamic> json) {
    return GetIngredientsData(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      quantity: json['quantity'] / 1.0,
      unit: IngredientUnit.values[json['unit'] - 1],
    );
  }
}
