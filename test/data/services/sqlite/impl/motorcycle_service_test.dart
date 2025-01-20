import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/data/model/motorcycle_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';

import '../../../../../testing/data/model/motorcycle_model.dart';
import '../../../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';
import '../../../../../testing/data/services/sqlite/impl/motorcycle_service.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  IConnectionDb connection = ConnectionDbSqlite();
  final motorcycleService = MotorcycleService(connection: connection);

  group(('CRUD User by MotorcycleService class'), () {
    test('Must insert the data of a Motorcycle object into the database',
        () async {
      final result = await motorcycleService.create(data: motorcycleHonda);
      expect(result.asOk.value, isA<int>());
    });

    test('Should return a list of motorcycles', () async {
      final result = await motorcycleService.readAll();
      if (kDebugMode) {
        print(result.asOk.value);
      }
      expect(result.asOk.value, isA<List<Map>>());
    });
  });

  test('Must return a MotorcycleModel object by Id', () async {
    final result = await motorcycleService.readById(id: 2);
    expect(result.asOk.value, isA<MotorcycleModel>());
  });

  test('Must update a MotorcycleModel object.', () async {
    final result = await motorcycleService.update(
      data: MotorcycleModel(
        mot_id: 2,
        mot_cylinder_capacity: 400.0,
        mot_type: 'Falcon',
        mot_brand: 'Honda',
      ),
    );
    expect(result.asOk.value, isA<int>());
  });

  test('Must delete a MotorcycleModel object.', () async {
    final result = await motorcycleService.delete(
      data: MotorcycleModel(mot_id: 1),
    );
    expect(result.asOk.value, isA<int>());
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
