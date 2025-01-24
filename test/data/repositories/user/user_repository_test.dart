import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/impl/user_service.dart';
import 'package:boh_hummm/utils/result.dart';

import '../../../../testing/data/model/user_model.dart';
import '../../../../testing/data/repositories/user/user_repository.dart';
import '../../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  IConnectionDb connection = ConnectionDbSqlite();
  UserService userService = UserService(connection: connection);
  UserRepository userRepository = UserRepository(userService: userService);

  test('Must insert a UserEntity object', () async {
    final result = await userRepository.createUser(user: userREVIeGe);
    expect(result, isA<Ok<void>>());
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
