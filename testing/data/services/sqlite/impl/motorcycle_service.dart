import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/data/model/motorcycle_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';
import 'package:boh_hummm/utils/result.dart';

class MotorcycleService implements IService<MotorcycleModel> {
  final IConnectionDb connection;

  MotorcycleService({
    required this.connection,
  });

  @override
  Future<Result<int>> create({required MotorcycleModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int lastId = await result.value.rawInsert(
          "INSERT INTO motorcycle(mot_brand, mot_type, mot_cylinder_capacity, mot_use_id) VALUES (?, ?, ?, ?)",
          [
            data.mot_brand,
            data.mot_type,
            data.mot_cylinder_capacity,
            data.mot_use_id,
          ],
        );
        return Result.ok(lastId);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to insert motorcycle.'));
  }

  @override
  Future<Result<List<Map<String, Object?>>>> readAll() async {
    var result = await connection.initializeDatabase();
    var list = <Map<String, Object?>>[];

    if (result is Ok<Database>) {
      try {
        list = await result.value.rawQuery("SELECT * FROM motorcycle");
        if (list.isNotEmpty) {
          return Result.ok(list);
        }
        Result.error(Exception('Empty motorcycle List'));
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error returning the list of motorcycles.'));
  }

  @override
  Future<Result<MotorcycleModel>> readById({required int id}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        var response = await result.value.rawQuery(
          "SELECT * FROM motorcycle WHERE mot_id = ?",
          [id],
        );
        if (response.isNotEmpty) {
          return Result.ok(MotorcycleModel.fromMap(response.first));
        }
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error returning motorcycle by ID.'));
  }

  @override
  Future<Result<int>> update({required MotorcycleModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int id = await result.value.rawUpdate(
          "UPDATE motorcycle SET mot_brand = ?, mot_type = ?, mot_cylinder_capacity = ? WHERE mot_id = ?",
          [
            data.mot_brand,
            data.mot_type,
            data.mot_cylinder_capacity,
            data.mot_id,
          ],
        );
        return Result.ok(id);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to update motorcycle data.'));
  }

  @override
  Future<Result<int>> delete({required MotorcycleModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int id = await result.value.rawDelete(
          "DELETE FROM motorcycle WHERE mot_id = ?",
          [data.mot_id],
        );
        return Result.ok(id);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(
      Exception('Error trying to delete motorcycle from database.'),
    );
  }
}
