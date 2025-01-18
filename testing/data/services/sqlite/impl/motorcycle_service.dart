import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/data/model/motorcycle_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';

class MotorcycleService implements IService<MotorcycleModel> {
  final IConnectionDb connection;

  MotorcycleService({
    required this.connection,
  });

  @override
  Future<Result<int>> create({required MotorcycleModel data}) async {
    Database database = await connection.initializeDatabase();
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
      return Result.value(lastId);
    } catch (e, s) {
      Result.error(e, s);
    } finally {
      database.close();
    }
    return Result.error('Error trying to insert motorcycle.');
  }

  @override
  Future<Result<List<Map<String, Object?>>>> readAll() async {
    Database database = await connection.initializeDatabase();
    var list = <Map<String, Object?>>[];
    try {
      list = await database.rawQuery("SELECT * FROM motorcycle");
      if (list.isNotEmpty) {
        return Result.value(list);
      }
    } catch (e, s) {
      Result.error(e, s);
    } finally {
      database.close();
    }
    return Result.error('Error returning the list of motorcycles.');
  }

  @override
  Future<Result<MotorcycleModel>> readById({required int id}) async {
    Database database = await connection.initializeDatabase();
    try {
      var result = await database.rawQuery(
        "SELECT * FROM motorcycle WHERE mot_id = ?",
        [id],
      );
      if (result.isNotEmpty) {
        return Result.value(MotorcycleModel.fromMap(result.first));
      }
    } catch (e, s) {
      Result.error(e, s);
    } finally {
      database.close();
    }
    return Result.error('Error returning motorcycle by ID.');
  }

  @override
  Future<Result<int>> update({required MotorcycleModel data}) async {
    Database database = await connection.initializeDatabase();
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
      return Result.value(id);
    } catch (e, s) {
      Result.error(e, s);
    } finally {
      database.close();
    }
    return Result.error('Error trying to update motorcycle data.');
  }

  @override
  Future<Result<int>> delete({required MotorcycleModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int id = await database.rawDelete(
        "DELETE FROM motorcycle WHERE mot_id = ?",
        [data.mot_id],
      );
      return Result.value(id);
    } catch (e, s) {
      Result.error(e, s);
    } finally {
      database.close();
    }
    return Result.error('Error trying to delete motorcycle from database.');
  }
}
