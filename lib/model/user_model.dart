// ignore_for_file: non_constant_identifier_names

import 'motorcycle_model.dart';

class UserModel {
  final int? use_id;
  final String? use_name;
  final String? use_email;
  final String? use_image;
  final List<MotorcycleModel>? motorcycles;

  UserModel({
    this.use_id,
    this.use_name,
    this.use_email,
    this.use_image,
    this.motorcycles,
  });
}
