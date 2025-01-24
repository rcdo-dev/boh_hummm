import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boh_hummm/data/model/motorcycle_model.dart';

import '../../../testing/data/model/motorcycle_model.dart';

void main() {
  test('Must transform a Motorcycle object into a Map.', () {
    var map = motorcycleHonda.toMap();
    if (kDebugMode) {
      print(map);
    }
    expect(map, isA<Map>());
  });

  test('Must transform a map into a User object.', () {
    var moto = MotorcycleModel.fromMap(motorcycleHonda.toMap());
    if (kDebugMode) {
      print(
        '''
          Id: ${moto.mot_id}
          Brand: ${moto.mot_brand}
          Type: ${moto.mot_type}
          CC: ${moto.mot_cylinder_capacity}
          Id User: ${moto.mot_use_id}
        ''',
      );
    }
  });
}
