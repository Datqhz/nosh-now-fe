class LoginRequest {
  String userName;
  String password;

  LoginRequest({
    required this.userName,
    required this.password
  });
  
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password
    };
  }
}