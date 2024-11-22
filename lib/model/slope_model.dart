// ignore_for_file: non_constant_identifier_names

import 'delivery_route_model.dart';
import 'motorcycle_model.dart';

class SlopeModel {
  final int? slo_id;
  final String? slo_date;
  final double? slo_value;
  final MotorcycleModel? slo_mot_id;
  final List<DeliveryRouteModel>? deliveryRoutes;

  SlopeModel({
    this.slo_id,
    this.slo_date,
    this.slo_value,
    this.slo_mot_id,
    this.deliveryRoutes,
  });
}
