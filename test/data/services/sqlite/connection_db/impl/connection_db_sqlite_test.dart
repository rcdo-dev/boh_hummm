import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  final connection = ConnectionDbSqlite();

  test('Must return a database connection.', () async {
    var database = await connection.initializeDatabase();
    expect(database, isA<Database>());
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
