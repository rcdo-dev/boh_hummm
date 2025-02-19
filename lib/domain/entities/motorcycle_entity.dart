import 'package:boh_hummm/domain/entities/slope_entity.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';

class MotorcycleEntity {
  final String? brand;
  final String? type;
  final double? cylinderCapacity;
  final UserEntity? user;
  final SlopeEntity? slope;

  MotorcycleEntity({
    this.brand,
    this.type,
    this.cylinderCapacity,
    this.user,
    this.slope,
  });

  factory MotorcycleEntity.fromMap(Map<String, Object?> map,
      {UserEntity? user, SlopeEntity? slope}) {
    return MotorcycleEntity(
      brand: map['mot_brand'] as String,
      type: map['mot_type'] as String,
      cylinderCapacity: map['mot_cylinder_capacity'] as double,
      user: user,
      slope: slope,
    );
  }
}
