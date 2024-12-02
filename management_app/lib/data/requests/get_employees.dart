import 'package:management_app/data/models/restaurant_role.dart';

class GetEmployeesRequest {
  RestaurantRole role;
  String keyword;
  int pageNumber;
  int maxPerPage;

  GetEmployeesRequest(
      {required this.role,
      required this.keyword,
      required this.maxPerPage,
      required this.pageNumber});

  Map<String, dynamic> toJson() {
    return {
      'role': role.index,
      'keyword': keyword,
      'pageNumber': pageNumber,
      'maxPerPage': maxPerPage
    };
  }
}
