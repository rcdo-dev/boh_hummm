// ignore_for_file: non_constant_identifier_names

import 'package:boh_hummm/data/model/motorcycle_model.dart';

class UserModel {
  final int? use_id;
  final String? use_name;
  final String? use_email;
  final String? use_image_path;
  final List<MotorcycleModel>? motorcycles;

  UserModel({
    this.use_id,
    this.use_name,
    this.use_email,
    this.use_image_path,
    this.motorcycles,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['use_id'] = use_id;
    map['use_name'] = use_name;
    map['use_email'] = use_email;
    map['use_image_path'] = use_image_path;
    return map;
  }

  factory UserModel.fromMap(
    Map<String, Object?> map, {
    List<MotorcycleModel>? motorcycles,
  }) {
    return UserModel(
      use_id: int.tryParse(map['use_id'].toString()),
      use_name: map['use_name'].toString(),
      use_email: map['use_email'].toString(),
      use_image_path: map['use_image_path'].toString(),
      motorcycles: motorcycles,
    );
  }
}
