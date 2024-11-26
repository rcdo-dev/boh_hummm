import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/config/connection_db/i_connection_db.dart';
import 'package:boh_hummm/config/connection_db/impl/connection_db_sqlite.dart';
import 'package:boh_hummm/dao/i_dao.dart';
import 'package:boh_hummm/model/slope_model.dart';

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
  Future<List<Map<String, Object?>>> getAll() async {
    Database database = await connection.connectionDatabase();
    var list = <Map<String, Object?>>[];
    try {
      list = await database.rawQuery("SELECT * FROM slope");
      if (list.isNotEmpty) {
        return list;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to return all slopes.';
  }

  @override
  Future<SlopeModel> getById({required int id}) async {
    Database database = await connection.connectionDatabase();
    try {
      var result = await database.rawQuery(
        "SELECT * FROM slope WHERE slo_id = ?",
        [id],
      );
      if (result.isNotEmpty) {
        return SlopeModel.fromMap(result.first);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error when trying to return the slope by ID.';
  }

  @override
  Future<int> update({required SlopeModel data}) async {
    Database database = await connection.connectionDatabase();
    try {
      int id = await database.rawUpdate(
        "UPDATE slope SET slo_date = ?, slo_value = ? WHERE slo_id = ?",
        [data.slo_date, data.slo_value, data.slo_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to update slope data.';
  }

  @override
  Future<int> delete({required SlopeModel data}) async {
    Database database = await connection.connectionDatabase();
    try {
      int id = await database.rawDelete(
        "DELETE FROM slope WHERE slo_id = ?",
        [data.slo_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to delete slope data.';
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
      expect(lastId, isA<int>());
    });

    test('Must return all slope records.', () async {
      var list = await slopeDao.getAll();
      if (kDebugMode) {
        print(list);
      }
      expect(list, isNotEmpty);
    });

    test('Must return to slope by ID.', () async {
      var slope = await slopeDao.getById(id: 3);
      if (kDebugMode) {
        print(
          'ID: ${slope.slo_id}\nDate: ${slope.slo_date}\nValue: ${slope.slo_value}\nFK: ${slope.slo_mot_id}',
        );
      }
      expect(slope, isA<SlopeModel>());
    });

    test('Must update the slope data.', () async {
      var id = await slopeDao.update(
        data: SlopeModel(
          slo_id: 2,
          slo_date: DateTime(2024, 11, 26).toIso8601String().split('T')[0],
          slo_value: 65,
        ),
      );
      expect(id, isA<int>());
    });

    test('Must delete the slope data.', () async {
      var id = await slopeDao.delete(
        data: SlopeModel(
          slo_id: 1,
        ),
      );
      expect(id, isA<int>());
    });
  });
}
