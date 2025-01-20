import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../../testing/data/model/delivery_model.dart';
import '../../../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';
import '../../../../../testing/data/services/sqlite/impl/delivery_service.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  IConnectionDb connection = ConnectionDbSqlite();
  final deliveryService = DeliveryService(connection: connection);

  group('CRUD User by DeliveryService class', () {
    test('Must insert the data of a Delivery object into the database',
        () async {
      final result = await deliveryService.create(data: deliveryOne);
      if(kDebugMode){
        print(result.asError.error);
      }
      expect(result.asOk.value, isA<int>());
    });
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
