import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/data/model/delivery_route_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';

class DeliveryRouteService {
  final IConnectionDb connection;

  DeliveryRouteService({
    required this.connection,
  });

  @override
  Future<int> create({required DeliveryRouteModel data}) async {
    Database database = await connection.initializeDatabase();
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

  @override
  Future<int> delete({required DeliveryRouteModel data}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, Object?>>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<DeliveryRouteModel> readById({required int id}) {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<int> update({required DeliveryRouteModel data}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
