// ignore_for_file: non_constant_identifier_names

import 'delivery_route_model.dart';

class DeliveryModel {
  final int? del_id;
  final int? del_order;
  final double? del_fee;
  final DeliveryRouteModel? del_delr_id;

  DeliveryModel({
    this.del_id,
    this.del_order,
    this.del_fee,
    this.del_delr_id,
  });
}
