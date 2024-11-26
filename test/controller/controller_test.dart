import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/config/connection_db/i_connection_db.dart';
import 'package:boh_hummm/config/connection_db/impl/connection_db_sqlite.dart';
import 'package:boh_hummm/dao/i_dao.dart';
import 'package:boh_hummm/dao/impl/user_dao.dart';
import 'package:boh_hummm/model/user_model.dart';

class Controller<T> {
  final IDao dao;

  Controller({
    required this.dao,
  });

  Future<int> addData(T data) async {
    return await dao.insert(data: data);
  }

  Future<List<Map<String, Object?>>> fetchAllData() async {
    return await dao.getAll();
  }

  Future<T> fetchDataById({required int id}) async {
    return await dao.getById(id: id);
  }

  Future<int> updateData({required T data}) async {
    return await dao.update(data: data);
  }

  Future<int> deleteData({required T data}) async {
    return await dao.delete(data: data);
  }
}

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  IConnectionDb connection = ConnectionDbSqlite();
  UserDao userDao = UserDao(connection: connection);
  var controller = Controller<UserModel>(dao: userDao);

  test('description', () async {
    int lastId = await controller.addData(
      UserModel(
          use_name: 'Paulo',
          use_email: 'Paulo@test.com',
          use_image_path: 'path/folder/file.jpg'),
    );
    expect(lastId, isA<int>());
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
