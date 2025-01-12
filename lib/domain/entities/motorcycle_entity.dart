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
}
