// ignore_for_file: non_constant_identifier_names

import 'package:boh_hummm/model/user_model.dart';

class MotorcycleModel {
  final int? mot_id;
  final String? mot_brand;
  final String? mot_type;
  final double? mot_cylinder_capacity;
  final UserModel? mot_use_id;

  MotorcycleModel({
   this.mot_id,
    this.mot_brand,
    this.mot_type,
    this.mot_cylinder_capacity,
    this.mot_use_id,
  });
}
