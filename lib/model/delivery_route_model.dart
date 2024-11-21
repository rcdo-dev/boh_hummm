import 'package:boh_hummm/model/slope_model.dart';

import 'delivery_model.dart';

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
