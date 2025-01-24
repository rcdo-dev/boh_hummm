import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boh_hummm/data/model/slope_model.dart';

import '../../../testing/data/model/slope_model.dart';

void main() {
  test('Must transform a Slope object into a Map.', () {
    var map = slopeOne.toMap();
    if (kDebugMode) {
      print(map);
    }
    expect(map, isA<Map>());
  });

  test('Must transform a map into a User object.', () {
    var slope = SlopeModel.fromMap(slopeOne.toMap());
    if (kDebugMode) {
      print(
        '''
          Data: ${slope.slo_date}
          Valor: ${slope.slo_value}
          Id Moto: ${slope.slo_mot_id}
        ''',
      );
    }
  });
}
