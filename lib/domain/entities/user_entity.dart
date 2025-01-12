import 'package:boh_hummm/domain/entities/motorcycle_entity.dart';

class UserEntity {
  final String? name;
  final String? email;
  final String? imagePath;
  final List<MotorcycleEntity>? motorcycles;

  UserEntity({
    this.name,
    this.email,
    this.imagePath,
    this.motorcycles,
  });
}
