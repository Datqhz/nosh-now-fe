class UpdateEmployeeRequest {
  String employeeId;
  String displayname;
  String phoneNumber;
  String avatar;

  UpdateEmployeeRequest({
    required this.employeeId,
    required this.displayname,
    required this.phoneNumber,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'displayname': displayname,
      'phoneNumber': phoneNumber,
      'avatar': avatar
    };
  }
}