class DeliveryInfo {
  String phone;
  String coordinate;

  DeliveryInfo({
    required this.phone,
    required this.coordinate
  });

  factory DeliveryInfo.fromJson(Map<dynamic, dynamic> json) {
    return DeliveryInfo(
        phone: json['phone'],
        coordinate: json['coordinate']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'coordinate': coordinate
    };
  }
}