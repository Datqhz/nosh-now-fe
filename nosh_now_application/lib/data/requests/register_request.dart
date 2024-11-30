class RegisterRequest {
  String displayname;
  String userName;
  String password;
  String role = "Customer";
  String phoneNumber;
  String coordinate;
  String avatar;

  RegisterRequest({
    required this.displayname,
    required this.userName,
    required this.password,
    required this.phoneNumber,
    required this.avatar,
    required this.coordinate
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
    };
  }
}