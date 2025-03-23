import 'package:boh_hummm/domain/entities/motorcycle_entity.dart';

class UserEntity {
  final String? name;
  final String? email;
  final String? imagePath;
  final List<MotorcycleEntity> motorcycles;

  UserEntity({
    this.name,
    this.email,
    this.imagePath,
    final List<MotorcycleEntity>? motorcycles,
  }) : motorcycles =
            motorcycles != null ? List.unmodifiable(motorcycles) : const [];

  factory UserEntity.fromMap(
    Map<String, Object?> map, {
    List<MotorcycleEntity>? motorcycles,
  }) {
    return UserEntity(
      name: map['use_name'] as String,
      email: map['use_email'] as String,
      imagePath: map['use_image_path'] as String,
      motorcycles: motorcycles ?? [],
    );
  }

  UserEntity copyWith({
    String? name,
    String? email,
    String? imagePath,
    List<MotorcycleEntity>? motorcycles,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      motorcycles: motorcycles ?? this.motorcycles,
    );
  }
}
