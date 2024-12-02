class RegisterRequest {
  String displayname;
  String userName;
  String password;
  String role;
  String phoneNumber;
  String? coordinate;
  String? avatar;
  String? restaurantId;

  RegisterRequest({
    required this.displayname,
    required this.userName,
    required this.password,
    required this.phoneNumber,
    this.avatar,
    this.coordinate,
    required this.role,
    this.restaurantId
  });

  Map<String, dynamic> toJson() {
    return {
      'displayname': displayname,
      'userName': userName,
      'password': password,
      'role': role,
      'phoneNumber': phoneNumber,
      'coordinate': coordinate,
      'avatar': avatar,
      'restaurantId': restaurantId
    };
  }
}