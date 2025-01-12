import 'package:boh_hummm/domain/entities/delivery_entity.dart';
import 'package:boh_hummm/domain/entities/slope_entity.dart';

class DeliveryRouteEntity {
  final int? identifier;
  final SlopeEntity? slope;
  final List<DeliveryEntity>? deliveries;

  DeliveryRouteEntity({
    this.identifier,
    this.slope,
    this.deliveries,
  });
}
