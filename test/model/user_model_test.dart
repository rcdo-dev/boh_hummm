// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'motorcycle_model_test.dart';

class UserModel {
  final int? use_id;
  final String? use_name;
  final String? use_email;
  final String? use_image_path;
  final List<MotorcycleModel>? motorcycles;

  UserModel({
    this.use_id,
    this.use_name,
    this.use_email,
    this.use_image_path,
    this.motorcycles,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['use_id'] = use_id;
    map['use_name'] = use_name;
    map['use_email'] = use_email;
    map['use_image_path'] = use_image_path;
    return map;
  }

  factory UserModel.fromMap(
    Map<String, Object?> map, {
    List<MotorcycleModel>? motorcycles,
  }) {
    return UserModel(
      use_id: int.tryParse(map['use_id'].toString()),
      use_name: map['use_name'].toString(),
      use_email: map['use_email'].toString(),
      use_image_path: map['use_image_path'].toString(),
      motorcycles: motorcycles,
    );
  }
}

void main() {
  UserModel user = UserModel(
      use_id: 1,
      use_name: 'Ricardo',
      use_email: 'rcdo@email.com',
      use_image_path: 'path/file.png');

  // 1 - Buscar o usuário.
  var mapUser = <String, dynamic>{
    'use_id': 1,
    'use_name': 'Ricardo',
    'use_email': 'rcdo.dev@email.com',
    'use_image_path': 'path/file.png',
  };

  // 2 - Buscar as motos associadas ao usuário.
  var motorcyclesUser = [
    {
      'mot_id': 1,
      'mot_brand': 'Honda',
      'mot_type': 'Bros',
      'mot_cylinder_capacity': 149,
    },
    {
      'mot_id': 2,
      'mot_brand': 'Yamaha',
      'mot_type': 'Fazer',
      'mot_cylinder_capacity': 160,
    },
  ];

  test('Must transform a User object into a Map.', () {
    var map = user.toMap();
    if (kDebugMode) {
      print(map);
    }
    expect(map, isA<Map>());
  });

  test('Must transform a map into a User object.', () {
    // 3 - Converte o mapa de motos para objetos MotorcycleModel.
    List<MotorcycleModel> motorcycles = motorcyclesUser.map((moto) {
      return MotorcycleModel.fromMap(moto);
    }).toList();

    // 4 - Constrói UserModel com a lista de motos.
    var user = UserModel.fromMap(mapUser, motorcycles: motorcycles);
    if (kDebugMode) {
      print(
        '''
          ID: ${user.use_id}
          Name: ${user.use_name}
          Email: ${user.use_email}
          Image: ${user.use_image_path}
          Motorcycles: ${user.motorcycles?.length}
        ''',
      );
    }
    expect(user, isA<UserModel>());
  });
}
