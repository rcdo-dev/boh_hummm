import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/dao/connection_db/i_connection_db.dart';
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
