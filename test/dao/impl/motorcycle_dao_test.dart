import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/dao/connection_db/i_connection_db.dart';
import 'package:boh_hummm/dao/connection_db/impl/connection_db_sqlite.dart';
import 'package:boh_hummm/dao/i_dao.dart';

import 'package:boh_hummm/model/motorcycle_model.dart';

class MotorcycleDao implements IDao<MotorcycleModel> {
  final IConnectionDb connection;

  MotorcycleDao({
    required this.connection,
  });

  @override
  Future<int> insert({required MotorcycleModel data}) async {
    Database database = await connection.connectionDatabase();

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
      return lastId;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to insert motorcycle.';
  }

  @override
  Future<List<Map<String, Object?>>> getAll() async {
    Database database = await connection.connectionDatabase();
    var list = <Map<String, Object?>>[];
    try {
      list = await database.rawQuery("SELECT * FROM motorcycle");
      if (list.isNotEmpty) {
        return list;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error returning the list of motorcycles.';
  }

  @override
  Future<MotorcycleModel> getById({required int id}) async {
    Database database = await connection.connectionDatabase();
    try {
      var result = await database.rawQuery(
        "SELECT * FROM motorcycle WHERE mot_id = ?",
        [id],
      );
      if (result.isNotEmpty) {
        return MotorcycleModel.fromMap(result.first);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error returning motorcycle by ID.';
  }

  @override
  Future<int> update({required MotorcycleModel data}) async {
    Database database = await connection.connectionDatabase();
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
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to update motorcycle data.';
  }

  @override
  Future<int> delete({required MotorcycleModel data}) async {
    Database database = await connection.connectionDatabase();
    try {
      int id = await database.rawDelete(
        "DELETE FROM motorcycle WHERE mot_id = ?",
        [data.mot_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\n Stack: $s');
      }
    } finally {
      database.close();
    }
    return throw 'Error trying to delete motorcycle from database.';
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
  MotorcycleDao motorcycleDao = MotorcycleDao(connection: connection);

  MotorcycleModel motorcycle = MotorcycleModel(
    mot_brand: 'Honda',
    mot_type: 'Bros',
    mot_cylinder_capacity: 149,
    mot_use_id: 1,
  );

  group('CRUD User by MotorcycleDao class', () {
    test('This method should insert a motorcycle into the database.', () async {
      int lastId = await motorcycleDao.insert(data: motorcycle);
      expect(lastId, isA<int>());
    });

    test(
      'This method should return all motorcycles registered in the database.',
      () async {
        var list = await motorcycleDao.getAll();
        if (kDebugMode) {
          print(list);
        }
        expect(list, isA<List<Map<String, Object?>>>());
      },
    );

    test('Should return a MotorCycleModel object by ID.', () async {
      var motorcycle = await motorcycleDao.getById(id: 1);
      if (kDebugMode) {
        print(
          '''
          ID: ${motorcycle.mot_use_id}
          Brand: ${motorcycle.mot_brand}
          Type: ${motorcycle.mot_type}
          CC: ${motorcycle.mot_cylinder_capacity}
          FK: ${motorcycle.mot_use_id}
          ''',
        );
      }
      expect(motorcycle, isA<MotorcycleModel>());
    });

    test('You must update the motorcycle data in the database.', () async {
      int id = await motorcycleDao.update(
        data: MotorcycleModel(
          mot_id: 1,
          mot_brand: 'Yamaha',
          mot_type: 'Fazer',
          mot_cylinder_capacity: 250,
        ),
      );
      expect(id, isA<int>());
    });

    test('Must delete motorcycle from database.', () async {
      int id = await motorcycleDao.delete(
        data: MotorcycleModel(mot_id: 1),
      );
      expect(id, isA<int>());
    });
  });
}
