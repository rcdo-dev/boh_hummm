import 'motorcycle_model.dart';

class UserModel {
  final String? name;
  final String? email;
  final String? photoPath;
  final List<MotorcycleModel>? motorcycles;

  UserModel({
    this.name,
    this.email,
    this.photoPath,
    this.motorcycles,
  });
}
