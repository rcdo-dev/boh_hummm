import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boh_hummm/data/model/delivery_model.dart';

import '../../../testing/data/model/delivery_model.dart';

void main() {
  test('Must transform a User object into a Map.', () {
    var map = deliveryOne.toMap();
    if (kDebugMode) {
      print(map);
    }
    expect(map, isA<Map>());
  });

  test('Must transform a map into a User object.', () {
    var delivery = DeliveryModel.fromMap(deliveryOne.toMap());
    if (kDebugMode) {
      print(
        '''
          Comanda: ${delivery.del_order}
          Taxa: ${delivery.del_fee}
          Id rota de entrega: ${delivery.del_delr_id}
        ''',
      );
    }
  });
}
