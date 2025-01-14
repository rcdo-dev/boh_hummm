import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/data/model/slope_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';

class SlopeService implements IService<SlopeModel> {
  final IConnectionDb connection;

  SlopeService({
    required this.connection,
  });

  @override
  Future<int> create({required SlopeModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int lastId = await database.rawInsert(
        "INSERT INTO slope(slo_date, slo_value, slo_mot_id) VALUES (?, ?, ?)",
        [data.slo_date, data.slo_value, data.slo_mot_id],
      );
      return lastId;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error when trying to enter a slope value.';
  }

  @override
  Future<List<Map<String, Object?>>> readAll() async {
    Database database = await connection.initializeDatabase();
    var list = <Map<String, Object?>>[];
    try {
      list = await database.rawQuery("SELECT * FROM slope");
      if (list.isNotEmpty) {
        return list;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to return all slopes.';
  }

  @override
  Future<SlopeModel> readById({required int id}) async {
    Database database = await connection.initializeDatabase();
    try {
      var result = await database.rawQuery(
        "SELECT * FROM slope WHERE slo_id = ?",
        [id],
      );
      if (result.isNotEmpty) {
        return SlopeModel.fromMap(result.first);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error when trying to return the slope by ID.';
  }

  @override
  Future<int> update({required SlopeModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int id = await database.rawUpdate(
        "UPDATE slope SET slo_date = ?, slo_value = ? WHERE slo_id = ?",
        [data.slo_date, data.slo_value, data.slo_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to update slope data.';
  }

  @override
  Future<int> delete({required SlopeModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int id = await database.rawDelete(
        "DELETE FROM slope WHERE slo_id = ?",
        [data.slo_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to delete slope data.';
  }
}