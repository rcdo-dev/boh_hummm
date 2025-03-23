import 'package:boh_hummm/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/impl/connection_db_sqlite.dart';
import 'package:boh_hummm/data/services/sqlite/impl/motorcycle_service.dart';
import 'package:boh_hummm/data/services/sqlite/impl/user_service.dart';
import 'package:boh_hummm/data/repositories/user_repository.dart';

import '../../../testing/data/model/user_model.dart';
import '../../../testing/ui/user/user_viewmodel.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();
    // Tells sqflite to use the database factory provided by sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;
  });

  late IConnectionDb connection;
  late UserService userService;
  late MotorcycleService motorcycleService;
  late UserRepository userRepository;
  late UserViewModel userViewModel;

  setUp(() {
    connection = ConnectionDbSqlite();
    userService = UserService(connection: connection);
    motorcycleService = MotorcycleService(connection: connection);
    userRepository = UserRepository(
      userService: userService,
      motorcycleService: motorcycleService,
    );
    userViewModel = UserViewModel(userRepository: userRepository);
  });

  test('Must save the user to the database from the ViewModel.', () async{
    await userViewModel.saveUser.execute(ricardoOunico);
    expect(userViewModel.saveUser.completed, true);
  });

  tearDownAll(() {
    if (kDebugMode) {
      print('Tests completed.');
    }
  });
}
