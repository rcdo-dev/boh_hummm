// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boh_hummm/model/user_model.dart';

class MotorcycleModel {
  final int? mot_id;
  final String? mot_brand;
  final String? mot_type;
  final double? mot_cylinder_capacity;
  final UserModel? user;

  MotorcycleModel({
    this.mot_id,
    this.mot_brand,
    this.mot_type,
    this.mot_cylinder_capacity,
    this.user,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['mot_id'] = mot_id;
    map['mot_brand'] = mot_brand;
    map['mot_type'] = mot_type;
    map['mot_cylinder_capacity'] = mot_cylinder_capacity;
    map['mot_use_id'] = user?.use_id;
    return map;
  }

  factory MotorcycleModel.fromMap(
    Map<String, Object?> map, {
    UserModel? user,
  }) {
    return MotorcycleModel(
      mot_id: int.tryParse(map['mot_id'].toString()),
      mot_brand: map['mot_brand'].toString(),
      mot_type: map['mot_type'].toString(),
      mot_cylinder_capacity: double.tryParse(
        map['mot_cylinder_capacity'].toString(),
      ),
      user: user,
    );
  }
}

void main() {
  MotorcycleModel motorcycle = MotorcycleModel(
    mot_id: 1,
    mot_brand: 'Honda',
    mot_type: 'Bros',
    mot_cylinder_capacity: 149,
    user: UserModel(
      use_id: 1,
    ),
  );

  var mapMotorcycleModel = <String, dynamic>{
    'mot_id': 1,
    'mot_brand': 'Honda',
    'mot_type': 'Bros',
    'mot_cylinder_capacity': 149,
  };

  // Posso buscar o usuário através da chave 'mot_use_id'.

  test('Must transform a MotorcycleModel object into a map.', () {
    var map = motorcycle.toMap();
    if (kDebugMode) {
      print(map);
    }
    expect(map, isA<Map>());
  });

  test('Must transform a map into a MotorcycleModel object.', () {
    var motorcycleObject = MotorcycleModel.fromMap(mapMotorcycleModel);
    if (kDebugMode) {
      print('''
        ID: ${motorcycleObject.mot_id}
        Brand: ${motorcycleObject.mot_brand}
        Type: ${motorcycleObject.mot_type}
        CC: ${motorcycleObject.mot_cylinder_capacity}
        ''');
    }
    expect(motorcycleObject, isA<MotorcycleModel>());
  });
}
