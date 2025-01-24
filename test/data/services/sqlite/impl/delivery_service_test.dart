import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/data/model/delivery_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';

import '../../../../../testing/data/model/delivery_model.dart';
import '../../../../../testing/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';
import '../../../../../testing/data/services/sqlite/impl/delivery_service.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  IConnectionDb connection = ConnectionDbSqlite();
  final deliveryService = DeliveryService(connection: connection);

  group('CRUD User by DeliveryService class', () {
    test('Must insert the data of a Delivery object into the database',
        () async {
      final result = await deliveryService.create(data: deliveryTwo);
      expect(result.asOk.value, isA<int>());
    });
  });

  test('Should return an exception when inserting a duplicate delivery.',
      () async {
    final result = await deliveryService.create(data: deliveryOne);
    expect(result.asError.error, isA<Exception>());
  });

  test('It must return a list with the data of the Delivery', () async {
    final result = await deliveryService.readAll();
    if (kDebugMode) {
      print(result.asOk.value);
    }
    expect(result.asOk.value, isA<List<Map>>());
  });

  test('It should return a DeliveryModel object by Id.', () async {
    final result = await deliveryService.readById(id: 1);
    if (kDebugMode) {
      print(result.asOk.value.del_fee);
    }
    expect(result.asOk.value, isA<DeliveryModel>());
  });

  test('Must update a DeliveryModel object', () async {
    final result = await deliveryService.update(
      data: DeliveryModel(
        del_id: 1,
        del_order: 002,
        del_fee: 25.0,
        del_delr_id: 1,
      ),
    );
    expect(result.asOk.value, isA<int>());
  });

  test('Must delete a DeliveryModel object', () async {
    final result = await deliveryService.delete(
      data: DeliveryModel(del_id: 2),
    );
    expect(result.asOk.value, isA<int>());
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
