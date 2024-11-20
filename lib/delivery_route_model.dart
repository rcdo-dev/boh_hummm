import 'package:boh_hummm/delivery_model.dart';
import 'package:boh_hummm/slope_model.dart';

class DeliveryRouteModel {
  final int? identifier;
  final SlopeModel? slope;
  final List<DeliveryModel>? deliveries;

  DeliveryRouteModel({
    this.identifier,
    this.slope,
    this.deliveries,
  });
}
