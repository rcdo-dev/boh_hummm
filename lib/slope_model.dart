import 'package:boh_hummm/delivery_route_model.dart';
import 'package:boh_hummm/motorcycle_model.dart';

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
