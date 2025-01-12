import 'package:boh_hummm/domain/entities/delivery_route_entity.dart';

class DeliveryEntity {
  final int? order;
  final double? fee;
  final DeliveryRouteEntity? deliveryRoute;

  DeliveryEntity({
    this.order,
    this.fee,
    this.deliveryRoute,
  });
}
