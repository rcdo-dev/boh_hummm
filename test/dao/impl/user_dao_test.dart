import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/config/connection_db/i_connection_db.dart';
import 'package:boh_hummm/config/connection_db/impl/connection_db_sqlite.dart';
import 'package:boh_hummm/dao/i_dao.dart';
import 'package:boh_hummm/model/user_model.dart';

class UserDao implements IDao<UserModel> {
  final IConnectionDb connection;

  UserDao({
    required this.connection,
  });

  @override
  Future<int> insert({required UserModel data}) async {
    Database database = await connection.connectionDatabase();
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
  Future<List<Map<String, Object?>>> getAll() async {
    Database database = await connection.connectionDatabase();
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
  Future<UserModel> getById({required int id}) async {
    Database database = await connection.connectionDatabase();
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
    Database database = await connection.connectionDatabase();
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
    Database database = await connection.connectionDatabase();
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

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  IConnectionDb connectionSqlite = ConnectionDbSqlite();
  UserDao userDao = UserDao(connection: connectionSqlite);

  UserModel userTest = UserModel(
    use_name: 'Ricardo',
    use_email: 'rcdo@test.com',
    use_image_path: 'path/file.png',
    motorcycles: [],
  );

  UserModel userUpdateTest = UserModel(
    use_id: 4,
    use_name: 'Felipe Mendes',
    use_email: 'felipe_mendes@test.com',
    use_image_path: 'path/file.png',
    motorcycles: [],
  );

  group('CRUD User by UserDao class', () {
    test('Must insert the data of a User object into the database', () async {
      int? lastId = await userDao.insert(data: userTest);
      expect(lastId, isA<int>());
    });

    test('It must return a list with the data of the Users', () async {
      var list = await userDao.getAll();
      if (kDebugMode) {
        print(list);
      }
      expect(list, isA<List<Map>>());
    });

    test('Must return a UserModel object after performing a database query',
        () async {
      var user = await userDao.getById(id: 2);
      if (kDebugMode) {
        print(
          "ID: ${user.use_id}\nName: ${user.use_name}\nE-mail: ${user.use_email}\nImage path: ${user.use_image_path}",
        );
      }
      expect(user, isA<UserModel>());
    });

    test('Must update data of the user', () async {
      var id = await userDao.update(data: userUpdateTest);
      expect(id, isA<int>());
    });

    test('Must exclude a user', () async {
      var id = await userDao.delete(data: UserModel(use_id: 1));
      expect(id, isA<int>());
    });
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
