import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
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

    // Mesmo bug em delivery, verificar!
    test('Must insert the data of a Slope object into the database', () async {
      final result = await slopeService.create(data: slopeOne);
      expect(result.asOk.value, isA<int>());
    });
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
