import 'package:boh_hummm/data/model/slope_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';
import 'package:boh_hummm/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SlopeService implements IService<SlopeModel> {
  final IConnectionDb connection;

  SlopeService({
    required this.connection,
  });

  @override
  Future<Result<int>> create({required SlopeModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int lastId = await result.value.rawInsert(
          "INSERT INTO slope(slo_date, slo_value, slo_mot_id) VALUES (?, ?, ?)",
          [data.slo_date, data.slo_value, data.slo_mot_id],
        );
        return Result.ok(lastId);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error when trying to enter a slope value.'));
  }

  @override
  Future<Result<List<Map<String, Object?>>>> readAll() async {
    var result = await connection.initializeDatabase();
    var list = <Map<String, Object?>>[];

    if (result is Ok<Database>) {
      try {
        list = await result.value.rawQuery("SELECT * FROM slope");
        if (list.isNotEmpty) {
          return Result.ok(list);
        }
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to return all slopes.'));
  }

  @override
  Future<Result<SlopeModel>> readById({required int id}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        var response = await result.value.rawQuery(
          "SELECT * FROM slope WHERE slo_id = ?",
          [id],
        );
        if (response.isNotEmpty) {
          return Result.ok(SlopeModel.fromMap(response.first));
        }
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(
      Exception('Error when trying to return the slope by ID.'),
    );
  }

  @override
  Future<Result<int>> update({required SlopeModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int id = await result.value.rawUpdate(
          "UPDATE slope SET slo_date = ?, slo_value = ? WHERE slo_id = ?",
          [data.slo_date, data.slo_value, data.slo_id],
        );
        return Result.ok(id);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to update slope data.'));
  }

  @override
  Future<Result<int>> delete({required SlopeModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int id = await result.value.rawDelete(
          "DELETE FROM slope WHERE slo_id = ?",
          [data.slo_id],
        );
        return Result.ok(id);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to delete slope data.'));
  }
}
