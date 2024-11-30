
// class GetRestaurantResponse extends ErrorResponse {


//   GetRestaurantResponse({
//     required super.status, 
//     required super.statusText, 
//     required super.errorMessage,
//     required super.errorMessageCode,
//     this.data,
//     required this.paging
//   });

//   factory GetRestaurantResponse.fromJson(Map<dynamic, dynamic> json) {
//     return GetRestaurantResponse(
//       status: json['status'],
//       statusText: json['statusText'],
//       errorMessage: json['errorMessage'],
//       errorMessageCode: json['errorMessageCode'],
//       data: json['data'].map((e) => GetRestaurantData.fromJson(e)).toList(),
//       paging: PagingDto.fromJson(json['paging'])
//     );
//   }
// }


// class GetRestaurantData{
//   String id;
//   String displayName;
//   String coordinate;
//   String avatar;
  
//   GetRestaurantData({
//     required this.restaurantId, 
//     required this.restaurantName,
//     required this.distance,
//     required this.avatar
//   });

//   factory GetRestaurantData.fromJson(Map<dynamic, dynamic> json) {
//     return GetRestaurantData(
//       restaurantId: json['restaurantId'],
//       restaurantName: json['restaurantName'],
//       distance: json['distance'],
//       avatar: json['avatar'],
//     );
//   }
// }
