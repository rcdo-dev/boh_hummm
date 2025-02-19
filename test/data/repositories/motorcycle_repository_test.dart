import 'package:boh_hummm/utils/extensions/result_cast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/domain/entities/motorcycle_entity.dart';
import 'package:boh_hummm/utils/result.dart';

import '../../../testing/data/model/motorcycle_model.dart';
import '../../../testing/data/repositories/motorcycle_repository.dart';
import '../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';
import '../../../testing/data/services/sqlite/impl/motorcycle_service.dart';
import '../../../testing/data/services/sqlite/impl/user_service.dart';

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
    late UserService userService;
    late MotorcycleRepository motorcycleRepository;

    setUp(() {
      connection = ConnectionDbSqlite();
      motorcycleService = MotorcycleService(connection: connection);
      userService = UserService(connection: connection);
      motorcycleRepository = MotorcycleRepository(
        motorcycleService: motorcycleService,
        userService: userService,
      );
    });

    test('Must insert a motorcycle object.', () async {
      final result = await motorcycleRepository.createMotorcycle(
        motorcycleEntity: motorcycleHarley,
        idUser: 3,
      );
      expect(result, isA<Ok<void>>());
    });

    test('It should return a list of motorcycles with their respective users.',
        () async {
      final result = await motorcycleRepository.readAllMotorcycles();
      if (kDebugMode) {
        for (var moto in result.asOk.value){
          print(moto.user?.name);
        }
      }
      expect(result, isA<Ok<List<MotorcycleEntity>>>());
    });

    tearDownAll(() {
      if (kDebugMode) {
        print('Tests completed.');
      }
    });
  });
}
