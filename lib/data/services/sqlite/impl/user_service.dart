import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/data/model/user_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';
import 'package:boh_hummm/utils/result.dart';

class UserService implements IService<UserModel> {
  final IConnectionDb connection;

  UserService({
    required this.connection,
  });

  @override
  Future<Result<int>> create({required UserModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int lastId = await result.value.rawInsert(
          "INSERT INTO user(use_name, use_email, use_image_path) VALUES (?, ?, ?)",
          [data.use_name, data.use_email, data.use_image_path],
        );
        return Result.ok(lastId);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error when trying to insert.'));
  }

  @override
  Future<Result<List<Map<String, Object?>>>> readAll() async {
    var result = await connection.initializeDatabase();
    var list = <Map<String, Object?>>[];

    if (result is Ok<Database>) {
      try {
        list = await result.value.rawQuery("SELECT * FROM User");
        if (list.isNotEmpty) {
          return Result.ok(list);
        }
        Result.error(Exception('Empty user List'));
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to return all users.'));
  }

  @override
  Future<Result<UserModel>> readById({required int id}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        var response = await result.value.rawQuery(
          "SELECT * FROM user WHERE use_id = ?",
          [id],
        );
        if (response.isNotEmpty) {
          return Result.ok(UserModel.fromMap(response.first));
        }
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error when trying to select user by id.'));
  }

  @override
  Future<Result<int>> update({required UserModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int id = await result.value.rawUpdate(
          "UPDATE user SET use_name = ?, use_email = ?, use_image_path = ? WHERE use_id = ?",
          [data.use_name, data.use_email, data.use_image_path, data.use_id],
        );
        return Result.ok(id);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error when trying to update user'));
  }

  @override
  Future<Result<int>> delete({required UserModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int id = await result.value.rawDelete(
          "DELETE FROM user WHERE use_id = ?",
          [data.use_id],
        );
        return Result.ok(id);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error when trying to delete user'));
  }
}
