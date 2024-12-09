import 'package:management_app/data/responses/error_response.dart';

class ProfileResponse extends ErrorResponse {
  ProfileData? data;

  ProfileResponse(
      {required super.status,
      required super.statusText,
      required super.errorMessage,
      required super.errorMessageCode,
      this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
        status: json['status'],
        statusText: json['statusText'],
        errorMessage: json['errorMessage'],
        errorMessageCode: json['errorMessageCode'],
        data: json['data'] != null ? ProfileData.fromJson(json['data']) : null);
  }
}

class ProfileData {
  String id;
  String displayName;
  String avatar;
  String email;
  String phone;
  String? coordinate;

  ProfileData(
      {required this.id,
      required this.displayName,
      required this.avatar,
      required this.email,
      required this.phone,
      this.coordinate});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
        id: json['id'],
        displayName: json['displayName'],
        avatar: json['avatar'],
        email: json['email'],
        phone: json['phone'],
        coordinate: json['coordinate']);
  }
}
