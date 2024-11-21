import 'delivery_route_model.dart';

class DeliveryModel {
  final int? order;
  final double? fee;
  final DeliveryRouteModel? deliveryRoute;

  DeliveryModel({
    this.order,
    this.fee,
    this.deliveryRoute,
  });
}
