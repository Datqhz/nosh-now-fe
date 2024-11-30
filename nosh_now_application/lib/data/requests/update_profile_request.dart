class UpdateProfileRequest {
  String displayname;
  String phoneNumber;
  String avatar;

  UpdateProfileRequest({
    required this.displayname,
    required this.phoneNumber,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'displayname': displayname,
      'phoneNumber': phoneNumber,
      'avatar': avatar
    };
  }
}