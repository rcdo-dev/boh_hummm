import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../testing/data/model/motorcycle_model.dart';
import '../../../testing/data/repositories/motorcycle_repository.dart';
import '../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';
import '../../../testing/data/services/sqlite/impl/motorcycle_service.dart';

void main() {
  group('Test group for the motorcycle repository.', () {
    setUpAll(() {
      // Initialize sqflite_common_ffi
      sqfliteFfiInit();
      // Tells sqflite to use the database factory provided by sqflite_common_ffi
      databaseFactory = databaseFactoryFfi;
    });

    late IConnectionDb connection;
    late MotorcycleService motorcycleService;
    late MotorcycleRepository motorcycleRepository;

    setUp(() {
      connection = ConnectionDbSqlite();
      motorcycleService = MotorcycleService(connection: connection);
      motorcycleRepository = MotorcycleRepository(
        motorcycleService: motorcycleService,
      );
    });

    test('Must insert a motorcycle object.', () async {
      final result = await motorcycleRepository.createMotorcycle(
        motorcycleEntity: motorcycleHarley,
        idUser: 3,
      );
      expect(result, isA<Ok<void>>());
    });

    tearDownAll(() {
      if (kDebugMode) {
        print('Tests completed.');
      }
    });
  });
}
