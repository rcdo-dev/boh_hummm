import 'package:boh_hummm/dao/connection_db/i_connection_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/dao/i_dao.dart';
import 'package:boh_hummm/model/slope_model.dart';

import '../connection_db/impl/connection_db_sqlite_test.dart';

class SlopeDao implements IDao<SlopeModel> {
  final IConnectionDb connection;

  SlopeDao({
    required this.connection,
  });

  @override
  Future<int> insert({required SlopeModel data}) async {
    Database database = await connection.connectionDatabase();
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
  Future<List<Map<String, Object?>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<SlopeModel> getById({required int id}) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<int> update({required SlopeModel data}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> delete({required SlopeModel data}) {
    // TODO: implement delete
    throw UnimplementedError();
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
  SlopeDao slopeDao = SlopeDao(connection: connection);

  SlopeModel slope = SlopeModel(
    slo_date: DateTime(2024, 11, 25).toIso8601String().split('T')[0],
    slo_value: 45,
    slo_mot_id: 2,
  );

  group('CRUD Slope by SlopeDao class', () {
    test('Must record a slope value in the database.', () async {
      int lastId = await slopeDao.insert(data: slope);
    });
  });
}
