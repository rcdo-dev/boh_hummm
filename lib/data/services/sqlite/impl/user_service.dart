import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/data/model/user_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';

class UserService implements IService<UserModel> {
  final IConnectionDb connection;

  UserService({
    required this.connection,
  });

  @override
  Future<int> create({required UserModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int lastId = await database.rawInsert(
        "INSERT INTO user(use_name, use_email, use_image_path) VALUES (?, ?, ?)",
        [data.use_name, data.use_email, data.use_image_path],
      );
      return lastId;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error when trying to insert.';
  }

  @override
  Future<List<Map<String, Object?>>> readAll() async {
    Database database = await connection.initializeDatabase();
    var list = <Map<String, Object?>>[];
    try {
      list = await database.rawQuery("SELECT * FROM User");
      if (list.isNotEmpty) {
        return list;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to return all users.';
  }

  @override
  Future<UserModel> readById({required int id}) async {
    Database database = await connection.initializeDatabase();
    try {
      var result = await database.rawQuery(
        "SELECT * FROM user WHERE use_id = ?",
        [id],
      );
      if (result.isNotEmpty) {
        return UserModel.fromMap(result.first);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error when trying to select user by id.';
  }

  @override
  Future<int> update({required UserModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int id = await database.rawUpdate(
        "UPDATE user SET use_name = ?, use_email = ?, use_image_path = ? WHERE use_id = ?",
        [data.use_name, data.use_email, data.use_image_path, data.use_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error when trying to update user';
  }

  @override
  Future<int> delete({required UserModel data}) async {
    Database database = await connection.initializeDatabase();
    try {
      int id = await database.rawDelete(
        "DELETE FROM user WHERE use_id = ?",
        [data.use_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error when trying to delete user';
  }
}
