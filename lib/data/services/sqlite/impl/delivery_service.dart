import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/data/model/delivery_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';

class DeliveryService {
  final IConnectionDb connection;

  DeliveryService({
    required this.connection,
  });

  @override
  Future<int> create({required DeliveryModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int lastId = await database.rawInsert(
        "INSERT INTO delivery(del_order, del_fee, del_delr_id) VALUES (?, ?, ?)",
        [data.del_order, data.del_fee, data.del_delr_id],
      );
      return lastId;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error trying to insert a delivery.';
  }

  @override
  Future<List<Map<String, Object?>>> readAll() async {
    Database database = await connection.initializeDatabase();
    var list = <Map<String, Object?>>[];
    try {
      list = await database.rawQuery("SELECT * FROM delivery");
      if (list.isNotEmpty) {
        return list;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error trying to get all deliveries.';
  }

  @override
  Future<DeliveryModel> readById({required int id}) async {
    Database database = await connection.initializeDatabase();
    try {
      var result = await database.rawQuery(
        "SELECT * FROM delivery WHERE del_id = ?",
        [id],
      );
      return DeliveryModel.fromMap(result.first);
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error returning delivery by ID.';
  }

  @override
  Future<int> update({required DeliveryModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int id = await database.rawUpdate(
        "UPDATE delivery SET del_order = ?, del_fee = ? WHERE del_id = ?",
        [data.del_order, data.del_fee, data.del_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error trying to update delivery.';
  }

  @override
  Future<int> delete({required DeliveryModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int id = await database.rawDelete(
        "DELETE FROM delivery WHERE del_id = ?",
        [data.del_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error deleting delivery.';
  }
}
