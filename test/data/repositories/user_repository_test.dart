import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/impl/user_service.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';
import 'package:boh_hummm/utils/result.dart';

import '../../../testing/data/model/user_model.dart';
import '../../../testing/data/repositories/user_repository.dart';
import '../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';
import '../../../testing/data/services/sqlite/impl/motorcycle_service.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  late IConnectionDb connection;
  late UserService userService;
  late MotorcycleService motorcycleService;
  late UserRepository userRepository;

  setUp(() {
    connection = ConnectionDbSqlite();
    userService = UserService(connection: connection);
    motorcycleService = MotorcycleService(connection: connection);
    userRepository = UserRepository(
      userService: userService,
      motorcycleService: motorcycleService,
    );
  });

  group('Source of truth for the User type.', () {
    test('Must insert a UserEntity object', () async {
      final result = await userRepository.createUser(user: userREVIeGe);
      expect(result, isA<Ok<void>>());
    });

    test('Should return an exception when inserting a duplicate user.',
        () async {
      final result = await userRepository.createUser(user: userREVIeGe);
      expect(result, isA<Error<void>>());
    });

    test('Must return a list of UserEntity objects', () async {
      final result = await userRepository.readAllUsers();
      if (kDebugMode) {
        for (var element in result.asOk.value) {
          print(
            'name: ${element.name}\nemail: ${element.email}\nimage: ${element.imagePath}\nmotorcycles: ${element.motorcycles?.first.brand} | ${element.motorcycles?.first.type}\n\n',
          );
        }
      }
      expect(result, isA<Ok<List<UserEntity>>>());
    });

    test('Must return a user by Id.', () async {
      final result = await userRepository.readUserById(id: 3);
      if (kDebugMode) {
        print(
          'User:${result.asOk.value.name}\nType: ${result.asOk.value.motorcycles?.first.type}',
        );
      }
      expect(result, isA<Ok<UserEntity>>());
    });

    test('Must update user data.', () async {
      // Quando atualizar solicitar o e-mail do usuário como segurança.
      final userUpdate = UserEntity(
        name: 'Plamnumm',
        email: 'PLaMNuM@test.com',
        imagePath: 'path/plamnum.jpg',
      );
      final result = await userRepository.updateUser(userEntity: userUpdate);
      expect(result, isA<Ok<void>>());
    });
  });

  test('Must delete user data.', () async {
    final userDelete = UserEntity(
      email: 'CoNTeNI@test.com',
    );
    final result = await userRepository.deleteUser(userEntity: userDelete);
    expect(result, isA<Ok<void>>());
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
