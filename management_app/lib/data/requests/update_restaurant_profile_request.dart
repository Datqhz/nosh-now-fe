class UpdateRestaurantProfileRequest {
  String displayname;
  String phoneNumber;
  String avatar;
  String coordinate;

  UpdateRestaurantProfileRequest({
    required this.displayname,
    required this.phoneNumber,
    required this.avatar,
    required this.coordinate
  });

  Map<String, dynamic> toJson() {
    return {
      'displayname': displayname,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'coordinate': coordinate
    };
  }
}
