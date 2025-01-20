import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/data/model/delivery_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';
import 'package:boh_hummm/utils/result.dart';

class DeliveryService implements IService<DeliveryModel> {
  final IConnectionDb connection;

  DeliveryService({
    required this.connection,
  });

  @override
  Future<Result<int>> create({required DeliveryModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int lastId = await result.value.rawInsert(
          "INSERT INTO delivery(del_order, del_fee, del_delr_id) VALUES (?, ?, ?)",
          [data.del_order, data.del_fee, data.del_delr_id],
        );
        return Result.ok(lastId);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to insert a delivery.'));
  }

  @override
  Future<Result<List<Map<String, Object?>>>> readAll() async {
    var result = await connection.initializeDatabase();
    var list = <Map<String, Object?>>[];

    if (result is Ok<Database>) {
      try {
        list = await result.value.rawQuery("SELECT * FROM delivery");
        if (list.isNotEmpty) {
          return Result.ok(list);
        }
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to get all deliveries.'));
  }

  @override
  Future<Result<DeliveryModel>> readById({required int id}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        var response = await result.value.rawQuery(
          "SELECT * FROM delivery WHERE del_id = ?",
          [id],
        );
        return Result.ok(DeliveryModel.fromMap(response.first));
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error returning delivery by ID.'));
  }

  @override
  Future<Result<int>> update({required DeliveryModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int id = await result.value.rawUpdate(
          "UPDATE delivery SET del_order = ?, del_fee = ? WHERE del_id = ?",
          [data.del_order, data.del_fee, data.del_id],
        );
        return Result.ok(id);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to update delivery.'));
  }

  @override
  Future<Result<int>> delete({required DeliveryModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int id = await result.value.rawDelete(
          "DELETE FROM delivery WHERE del_id = ?",
          [data.del_id],
        );
        return Result.ok(id);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error deleting delivery.'));
  }
}
