import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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

    test('Should return an exception when inserting a duplicate motorcycle.',
        () async {
      final result = await motorcycleService.create(data: motorcycleHonda);
      if(kDebugMode){
        print(result.asError.error);
      }

      // Corrigir banco, está inserindo a mesma moto várias vezes.
      expect(result.asError.error, isA<Exception>());
    });
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
