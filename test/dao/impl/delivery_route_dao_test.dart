import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/config/connection_db/i_connection_db.dart';
import 'package:boh_hummm/config/connection_db/impl/connection_db_sqlite.dart';
import 'package:boh_hummm/dao/i_dao.dart';
import 'package:boh_hummm/model/delivery_route_model.dart';

class DeliveryRouteDao implements IInsertDao<DeliveryRouteModel> {
  final IConnectionDb connection;

  DeliveryRouteDao({
    required this.connection,
  });

  @override
  Future<int> insert({required DeliveryRouteModel data}) async {
    Database database = await connection.connectionDatabase();
    try {
      int lastId = await database.rawInsert(
        "INSERT INTO delivery_route(delr_identifier, delr_slo_id) VALUES (?, ?)",
        [data.delr_identifier, data.delr_slo_id],
      );
      return lastId;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    throw 'Error trying to enter a delivery route.';
  }
}

IConnectionDb connection = ConnectionDbSqlite();
DeliveryRouteDao deliveryRouteDao = DeliveryRouteDao(connection: connection);

DeliveryRouteModel deliveryRoute = DeliveryRouteModel(
  delr_identifier: 4,
  delr_slo_id: 3,
);

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  test('Must enter a delivery route.', () async {
    int lastId = await deliveryRouteDao.insert(data: deliveryRoute);
    expect(lastId, isA<int>());
  });
}
