class VehicleType {
  int typeId;
  String typeName;
  String icon;
  VehicleType(
      {required this.typeId, required this.typeName, required this.icon});
  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
        typeId: json['id'], typeName: json['typeName'], icon: json['icon']);
  }
  Map<String, dynamic> toJson() =>
      {'id': typeId, "typeName": typeName, 'icon': icon};
}
