import 'package:boh_hummm/domain/entities/delivery_route_entity.dart';
import 'package:boh_hummm/domain/entities/motorcycle_entity.dart';

class SlopeEntity {
  final String? date;
  final double? value;
  final MotorcycleEntity? motorcycle;
  final List<DeliveryRouteEntity>? deliveryRoutes;

  SlopeEntity({
    this.date,
    this.value,
    this.motorcycle,
    this.deliveryRoutes,
  });

  factory SlopeEntity.fromMap(
    Map<String, Object?> map, {
    MotorcycleEntity? motorcycle,
    List<DeliveryRouteEntity>? deliveryRoutes,
  }) {
    return SlopeEntity(
      date: map['slo_date'] as String,
      value: map['slo_value'] as double,
      motorcycle: motorcycle,
      deliveryRoutes: deliveryRoutes ?? [],
    );
  }
}
