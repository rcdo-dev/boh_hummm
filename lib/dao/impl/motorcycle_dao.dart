import 'package:flutter/foundation.dart';

import 'package:boh_hummm/dao/connection_db/i_connection_db.dart';
import 'package:boh_hummm/dao/i_dao.dart';
import 'package:boh_hummm/model/motorcycle_model.dart';

import 'package:sqflite/sqflite.dart';

class MotorcycleDao implements IDao<MotorcycleModel> {
  final IConnectionDb connection;

  MotorcycleDao({
    required this.connection,
  });

  @override
  Future<int> insert({required MotorcycleModel data}) async {
    Database database = await connection.connectionDatabase();

    try {
      int lastId = await database.rawInsert(
        "INSERT INTO motorcycle(mot_brand, mot_type, mot_cylinder_capacity, mot_use_id) VALUES (?, ?, ?, ?)",
        [
          data.mot_brand,
          data.mot_type,
          data.mot_cylinder_capacity,
          data.mot_use_id,
        ],
      );
      return lastId;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to insert motorcycle.';
  }

  @override
  Future<List<Map<String, Object?>>> getAll() async {
    Database database = await connection.connectionDatabase();
    var list = <Map<String, Object?>>[];
    try {
      list = await database.rawQuery("SELECT * FROM motorcycle");
      if (list.isNotEmpty) {
        return list;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error returning the list of motorcycles.';
  }

  @override
  Future<MotorcycleModel> getById({required int id}) async {
    Database database = await connection.connectionDatabase();
    try {
      var result = await database.rawQuery(
        "SELECT * FROM motorcycle WHERE mot_id = ?",
        [id],
      );
      if (result.isNotEmpty) {
        return MotorcycleModel.fromMap(result.first);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error returning motorcycle by ID.';
  }

  @override
  Future<int> update({required MotorcycleModel data}) async {
    Database database = await connection.connectionDatabase();
    try {
      int id = await database.rawUpdate(
        "UPDATE motorcycle SET mot_brand = ?, mot_type = ?, mot_cylinder_capacity = ? WHERE mot_id = ?",
        [
          data.mot_brand,
          data.mot_type,
          data.mot_cylinder_capacity,
          data.mot_id,
        ],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to update motorcycle data.';
  }

  @override
  Future<int> delete({required MotorcycleModel data}) async {
    Database database = await connection.connectionDatabase();
    try {
      int id = await database.rawDelete(
        "DELETE FROM motorcycle WHERE mot_id = ?",
        [data.mot_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to delete motorcycle from database.';
  }
}
