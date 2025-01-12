// ignore_for_file: non_constant_identifier_names

import 'delivery_model.dart';

class DeliveryRouteModel {
  final int? delr_id;
  final int? delr_identifier;
  final int? delr_slo_id;
  final List<DeliveryModel>? deliveries;

  DeliveryRouteModel({
    this.delr_id,
    this.delr_identifier,
    this.delr_slo_id,
    this.deliveries,
  });
}
