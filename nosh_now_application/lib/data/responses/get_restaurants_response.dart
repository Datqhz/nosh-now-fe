import 'package:nosh_now_application/data/responses/error_response.dart';
import 'package:nosh_now_application/data/responses/paging_dto.dart';

class GetRestaurantsResponse extends ErrorResponse {

  List<GetRestaurantsData>? data;
  PagingDto paging;
  GetRestaurantsResponse({
    required super.status, 
    required super.statusText, 
    required super.errorMessage,
    required super.errorMessageCode,
    this.data,
    required this.paging
  });

  factory GetRestaurantsResponse.fromJson(Map<dynamic, dynamic> json) {
    return GetRestaurantsResponse(
      status: json['status'],
      statusText: json['statusText'],
      errorMessage: json['errorMessage'],
      errorMessageCode: json['errorMessageCode'],
      data: json['data'] != null ? (json['data'] as List).map((e) => GetRestaurantsData.fromJson(e)).toList(): null,
      paging: PagingDto.fromJson(json['paging'])
    );
  }
}


class GetRestaurantsData{
  String restaurantId;
  String restaurantName;
  double distance;
  String coordinate;
  String avatar;
  
  GetRestaurantsData({
    required this.restaurantId, 
    required this.restaurantName,
    required this.distance,
    required this.avatar,
    required this.coordinate
  });

  factory GetRestaurantsData.fromJson(Map<dynamic, dynamic> json) {
    return GetRestaurantsData(
      restaurantId: json['restaurantId'],
      restaurantName: json['restaurantName'],
      distance: json['distance'],
      avatar: json['avatar'],
      coordinate: json['coordinate']
    );
  }
}
