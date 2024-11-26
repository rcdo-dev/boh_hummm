// ignore_for_file: non_constant_identifier_names

class MotorcycleModel {
  final int? mot_id;
  final String? mot_brand;
  final String? mot_type;
  final double? mot_cylinder_capacity;
  final int? mot_use_id;

  MotorcycleModel({
    this.mot_id,
    this.mot_brand,
    this.mot_type,
    this.mot_cylinder_capacity,
    this.mot_use_id,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['mot_id'] = mot_id;
    map['mot_brand'] = mot_brand;
    map['mot_type'] = mot_type;
    map['mot_cylinder_capacity'] = mot_cylinder_capacity;
    map['mot_use_id'] = mot_use_id;
    return map;
  }

  factory MotorcycleModel.fromMap(Map<String, Object?> map) {
    return MotorcycleModel(
      mot_id: int.tryParse(map['mot_id'].toString()),
      mot_brand: map['mot_brand'].toString(),
      mot_type: map['mot_type'].toString(),
      mot_cylinder_capacity: double.tryParse(
        map['mot_cylinder_capacity'].toString(),
      ),
      mot_use_id: int.tryParse(map['mot_use_id'].toString()),
    );
  }
}
