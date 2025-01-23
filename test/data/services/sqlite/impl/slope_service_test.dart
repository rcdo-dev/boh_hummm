import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boh_hummm/data/model/slope_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../../testing/data/model/slope_model.dart';
import '../../../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';
import '../../../../../testing/data/services/sqlite/impl/slope_service.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  IConnectionDb connection = ConnectionDbSqlite();
  final slopeService = SlopeService(connection: connection);

  group('CRUD Slope by SlopeService class', () {
    test('Must insert the data of a Slope object into the database', () async {
      final result = await slopeService.create(data: slopeOne);
      expect(result.asOk.value, isA<int>());
    });

    test('It must return a list with the data of the Slopes', () async {
      final result = await slopeService.readAll();
      if (kDebugMode) {
        print(result.asOk.value);
      }
      expect(result.asOk.value, isA<List<Map>>());
    });

    test('It should return a SlopeModel object by Id.', () async {
      final result = await slopeService.readById(id: 2);
      if (kDebugMode) {
        print(result.asOk.value.slo_date);
      }
      expect(result.asOk.value, isA<SlopeModel>());
    });

    test('Must update a SlopeModel object', () async {
      final result = await slopeService.update(
        data: SlopeModel(
          // id, date e value obrigatórios.
          slo_id: 3,
          slo_date: '2025-01-23',
          slo_value: 54.88,
          slo_mot_id: 3, // NOT NULL
        ),
      );
      expect(result.asOk.value, isA<int>());
    });

    test('Must delete a SlopeModel object', () async {
      final result = await slopeService.delete(
        data: SlopeModel(
          slo_id: 2,
        ),
      );
    });
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
