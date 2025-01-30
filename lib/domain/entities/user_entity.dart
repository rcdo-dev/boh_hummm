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

  factory UserEntity.fromMap(Map<String, Object?> map) {
    return UserEntity(
      name: map['use_name'] as String,
      email: map['use_email'] as String,
      imagePath: map['use_image_path'] as String,
    );
  }
}
