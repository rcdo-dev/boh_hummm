// ignore_for_file: non_constant_identifier_names

import 'package:boh_hummm/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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

  factory MotorcycleModel.fromMap(Map<String, Object?> map) {
    return MotorcycleModel(
      mot_id: int.tryParse(map['mot_id'].toString()),
      mot_brand: map['mot_brand'].toString(),
      mot_type: map['mot_type'].toString(),
      mot_cylinder_capacity: double.tryParse(
        map['mot_cylinder_capacity'].toString(),
      ),
      user: UserModel.fromMap(map['user'] as Map<String, Object?>),
    );
  }
}

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

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
    "mot_id": 1,
    'mot_brand': 'Honda',
    'mot_type': 'Bros',
    'mot_cylinder_capacity': 149,
     'user': {
       'use_id': 1,
       'use_name': 'Ricardo',
       'use_email': 'rcdo.dev@email.com',
       'use_image_path': 'path/file.png',
       'motorcycles': [],
     },
  };

  test('Must transform a MotorcycleModel object into a map.', (){
    var map = motorcycle.toMap();
    if(kDebugMode){
      print(map);
    }
    expect(map, isA<Map>());
  });

  test('Must transform a map into a MotorcycleModel object.', (){
    var motorcycleObject = MotorcycleModel.fromMap(mapMotorcycleModel);
    if(kDebugMode){
      print(
        '''
        ID: ${motorcycleObject.user?.use_id}
        Name: ${motorcycleObject.user?.use_name}
        Email: ${motorcycleObject.user?.use_email}
        Image: ${motorcycleObject.user?.use_image_path}
        Motorcycles: ${motorcycleObject.user?.motorcycles}
        '''
      );
    }
    expect(motorcycleObject, isA<MotorcycleModel>());
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
