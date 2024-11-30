import 'package:nosh_now_application/data/models/merchant.dart';

class MerchantWithDistance {
  Merchant merchant;
  double distance;
  MerchantWithDistance({required this.merchant, required this.distance});
  factory MerchantWithDistance.fromJson(Map<String, dynamic> json) {
    return MerchantWithDistance(
          merchant: Merchant.fromJson(json['merchant']),
          distance: json['distance']);
  }
}
