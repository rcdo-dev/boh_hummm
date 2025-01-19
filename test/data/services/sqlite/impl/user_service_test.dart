import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/model/user_model.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';

import '../../../../../testing/data/model/user_model.dart';
import '../../../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';
import '../../../../../testing/data/services/sqlite/impl/user_service.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  IConnectionDb connection = ConnectionDbSqlite();
  final userService = UserService(connection: connection);

  group('CRUD User by UserService class', () {
    test('Must insert the data of a User object into the database', () async {
      final result = await userService.create(data: userPLaMNuM);
      expect(result.asOk.value, isA<int>());
    });

    test('Should return an exception when inserting a duplicate user.',
        () async {
      final result = await userService.create(data: userSTanCel);
      if (kDebugMode) {
        print(result.asError.error);
      }
      expect(result.asError.error, isA<Exception>());
    });

    test('It must return a list with the data of the Users', () async {
      var result = await userService.readAll();
      if (kDebugMode) {
        print(result.asOk.value);
      }
      expect(result.asOk.value, isA<List<Map>>());
    });
  });

  test('It should return a UserModel object by Id.', () async {
    var result = await userService.readById(id: userSTanCel.use_id!);
    if (kDebugMode) {
      print(result.asOk.value.use_name);
    }
    expect(result.asOk.value, isA<UserModel>());
  });

  test('Must update a UserModel object', () async {
    var result = await userService.update(
      data: UserModel(
        use_id: 2,
        use_name: 'STanCel',
        use_email: 'stancel_updated@test.com',
        use_image_path: 'path/plamnum.jpg',
      ),
    );
    if (kDebugMode) {
      print(result.asOk.value);
    }
    expect(result.asOk.value, isA<int>());
  });

  test('Must delete a UserModel object', () async {
    var result = await userService.delete(data: UserModel(use_id: 2));
    expect(result.asOk.value, isA<int>());
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
