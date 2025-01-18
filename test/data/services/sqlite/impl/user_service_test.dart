import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';

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
      final result = await userService.create(data: databaseUser);
      expect(result.asValue?.value, isA<int>());
    });

    test('It must return a list with the data of the Users', () async {
      var result = await userService.readAll();
      if (kDebugMode) {
        // switch(result){
        //   case result.
        // }
      }
      expect(result.asValue?.value, isA<List<Map>>());
    });
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
