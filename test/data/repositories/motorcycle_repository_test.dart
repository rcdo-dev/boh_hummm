import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/impl/slope_service.dart';
import 'package:boh_hummm/domain/entities/motorcycle_entity.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';
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
    late SlopeService slopeService;
    late MotorcycleRepository motorcycleRepository;

    setUp(() {
      connection = ConnectionDbSqlite();
      motorcycleService = MotorcycleService(connection: connection);
      userService = UserService(connection: connection);
      slopeService = SlopeService(connection: connection);
      motorcycleRepository = MotorcycleRepository(
        motorcycleService: motorcycleService,
        userService: userService,
        slopeService: slopeService,
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
        for (var moto in result.asOk.value) {
          print('''
            Marca: ${moto.brand},
            Modelo: ${moto.type},
            Cilindradas: ${moto.cylinderCapacity},
            Usuário: ${moto.user?.name};
            Encosta: ${moto.slope?.value ?? 0};
              ''');
        }
      }
      expect(result, isA<Ok<List<MotorcycleEntity>>>());
    });

    test('Must return a motorcycle by id', () async {
      final result = await motorcycleRepository.readMotorcycleById(id: 5);
      if (kDebugMode) {
        print('''
          Marca: ${result.asOk.value.brand},
          Modelo: ${result.asOk.value.type},
          Cilindradas: ${result.asOk.value.cylinderCapacity},
          Usuário: ${result.asOk.value.user?.name};
          Encosta: ${result.asOk.value.slope?.value ?? 0};
        ''');
      }
      expect(result, isA<Ok<MotorcycleEntity>>());
    });

    test('Must update a motorcycle', () async {
      final result = await motorcycleRepository.updateMotorcycle(
        motorcycleEntity: MotorcycleEntity(
          brand: 'Yamaha',
          type: 'Fazer',
          cylinderCapacity: 300.0,
        ),
      );
      expect(result, isA<Ok<void>>());
    });

    test('Must delete a motorcycle', () async {
      final result = await motorcycleRepository.deleteMotorcycle(
        motorcycleEntity: MotorcycleEntity(
          type: 'Fazer',
        ),
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
