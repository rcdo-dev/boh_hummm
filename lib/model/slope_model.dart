import 'delivery_route_model.dart';
import 'motorcycle_model.dart';

class SlopeModel {
  final String? date;
  final double? value;
  final MotorcycleModel? motorcycle;
  final List<DeliveryRouteModel>? deliveryRoutes;

  SlopeModel({
    this.date,
    this.value,
    this.motorcycle,
    this.deliveryRoutes,
  });
}
