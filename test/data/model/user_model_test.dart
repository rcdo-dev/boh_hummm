import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boh_hummm/data/model/user_model.dart';

import '../../../testing/data/model/user_model.dart';

void main() {
  test('Must transform a User object into a Map.', () {
    var map = userPLaMNuM.toMap();
    if (kDebugMode) {
      print(map);
    }
    expect(map, isA<Map>());
  });

  test('Must transform a map into a User object.', () {
    var user = UserModel.fromMap(userPLaMNuM.toMap());
    if (kDebugMode) {
      print(
        '''
          ID: ${user.use_id}
          Name: ${user.use_name}
          Email: ${user.use_email}
          Image: ${user.use_image_path}
        ''',
      );
    }
  });
}
