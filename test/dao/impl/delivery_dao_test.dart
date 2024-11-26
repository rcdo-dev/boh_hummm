import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/dao/connection_db/i_connection_db.dart';
import 'package:boh_hummm/dao/connection_db/impl/connection_db_sqlite.dart';
import 'package:boh_hummm/dao/i_dao.dart';
import 'package:boh_hummm/model/delivery_model.dart';

class DeliveryDao implements IDao<DeliveryModel> {
  final IConnectionDb connection;

  DeliveryDao({
    required this.connection,
  });

  @override
  Future<int> insert({required DeliveryModel data}) async {
    Database database = await connection.connectionDatabase();
    try {
      int lastId = await database.rawInsert(
        "INSERT INTO delivery(del_order, del_fee, del_delr_id) VALUES (?, ?, ?)",
        [data.del_order, data.del_fee, data.del_delr_id],
      );
      return lastId;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error trying to insert a delivery.';
  }

  @override
  Future<List<Map<String, Object?>>> getAll() async {
    Database database = await connection.connectionDatabase();
    var list = <Map<String, Object?>>[];
    try {
      list = await database.rawQuery("SELECT * FROM delivery");
      if (list.isNotEmpty) {
        return list;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error trying to get all deliveries.';
  }

  @override
  Future<DeliveryModel> getById({required int id}) async {
    Database database = await connection.connectionDatabase();
    try {
      var result = await database.rawQuery(
        "SELECT * FROM delivery WHERE del_id = ?",
        [id],
      );
      return DeliveryModel.fromMap(result.first);
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error returning delivery by ID.';
  }

  @override
  Future<int> update({required DeliveryModel data}) async {
    Database database = await connection.connectionDatabase();
    try {
      int id = await database.rawUpdate(
        "UPDATE delivery SET del_order = ?, del_fee = ? WHERE del_id = ?",
        [data.del_order, data.del_fee, data.del_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error trying to update delivery.';
  }

  @override
  Future<int> delete({required DeliveryModel data}) async {
    Database database = await connection.connectionDatabase();
    try {
      int id = await database.rawDelete(
        "DELETE FROM delivery WHERE del_id = ?",
        [data.del_id],
      );
      return id;
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e.\n\nStackTrace: $s.');
      }
    } finally {
      database.close();
    }
    throw 'Error deleting delivery.';
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
  DeliveryDao deliveryDao = DeliveryDao(connection: connection);

  DeliveryModel delivery = DeliveryModel(
    del_order: 119,
    del_fee: 12,
    del_delr_id: 1,
  );

  test('Must enter a delivery.', () async {
    var lastId = await deliveryDao.insert(data: delivery);
    expect(lastId, isA<int>());
  });

  test('Must get all deliveries.', () async {
    var list = await deliveryDao.getAll();
    if (kDebugMode) {
      print(list);
    }
    expect(list, isA<List<Map<String, Object?>>>());
  });

  test('Must return delivery by ID.', () async {
    var delivery = await deliveryDao.getById(id: 2);
    if (kDebugMode) {
      print(
        'ID: ${delivery.del_id}\nOrder: ${delivery.del_order}\nFee: ${delivery.del_fee}\nFK: ${delivery.del_delr_id}',
      );
    }
    expect(delivery, isA<DeliveryModel>());
  });

  test('Must update the delivery.', () async {
    int id = await deliveryDao.update(
      data: DeliveryModel(
        del_id: 2,
        del_order: 452,
        del_fee: 50.96,
      ),
    );
    expect(id, isA<int>());
  });

  test('Must delete delivery.', () async {
    var id = await deliveryDao.delete(
      data: DeliveryModel(del_id: 1),
    );
    expect(id, isA<int>());
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
