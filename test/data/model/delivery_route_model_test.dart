import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boh_hummm/data/model/delivery_route_model.dart';

import '../../../testing/data/model/delivery_route_model.dart';

void main() {
  test('Must transform a DeliveryRoute object into a Map.', () {
    var map = deliveryRouteOne.toMap();
    if (kDebugMode) {
      print(map);
    }
    expect(map, isA<Map>());
  });

  test('Must transform a map into a User object.', () {
    var deliveryRoute = DeliveryRouteModel.fromMap(deliveryRouteOne.toMap());
    if (kDebugMode) {
      print(
        '''
          Número rota: ${deliveryRoute.delr_identifier}
          Id enconsta: ${deliveryRoute.delr_slo_id}
        ''',
      );
    }
  });
}
