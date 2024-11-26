// ignore_for_file: non_constant_identifier_names

import 'delivery_route_model.dart';
import 'motorcycle_model.dart';

class SlopeModel {
  final int? slo_id;
  final String? slo_date;
  final double? slo_value;
  final int? slo_mot_id;
  final List<DeliveryRouteModel>? deliveryRoutes;

  SlopeModel({
    this.slo_id,
    this.slo_date,
    this.slo_value,
    this.slo_mot_id,
    this.deliveryRoutes,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['slo_date'] = slo_date;
    map['slo_value'] = slo_value;
    map['slo_mot_id'] = slo_mot_id;
    return map;
  }

  factory SlopeModel.fromMap(Map<String, Object?> map) {
    return SlopeModel(
      slo_id: int.tryParse(map['slo_id'].toString()),
      slo_date: map['slo_date'].toString(),
      slo_value: double.tryParse(map['slo_value'].toString()),
      slo_mot_id: int.tryParse(map['slo_value'].toString()),
    );
  }
}
