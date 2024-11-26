import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:boh_hummm/dao/connection_db/i_connection_db.dart';

class ConnectionDbSqlite implements IConnectionDb<Database> {
  @override
  Future<Database> connectionDatabase() async {
    var documentDirectoryPath = await getDatabasesPath();
    var path = join(documentDirectoryPath, 'bohHummmLocalDatabase.db');

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE user(
            use_id INTEGER PRIMARY KEY AUTOINCREMENT,
            use_name TEXT UNIQUE NOT NULL,
            use_email TEXT,
            use_image_path TEXT
          );
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE motorcycle (
            mot_id INTEGER PRIMARY KEY AUTOINCREMENT,
            mot_brand TEXT,
            mot_type TEXT,
            mot_cylinder_capacity REAL,
            mot_use_id INTEGER NOT NULL,
            FOREIGN KEY (mot_use_id) REFERENCES user (use_id) ON DELETE CASCADE
          );
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE slope (
            slo_id INTEGER PRIMARY KEY AUTOINCREMENT,
            slo_date DATE NOT NULL,
            slo_value REAL,
            slo_mot_id INTEGER NOT NULL,
            FOREIGN KEY (slo_mot_id) REFERENCES motorcycle (mot_id) ON DELETE CASCADE
          );
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE delivery_route(
            delr_id INTEGER PRIMARY KEY AUTOINCREMENT,
            delr_identifier INTEGER,
            delr_slo_id INTEGER NOT NULL,
            FOREIGN KEY (delr_slo_id) REFERENCES slope (slo_id) ON DELETE CASCADE
          );
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE delivery(
            del_id INTEGER PRIMARY KEY AUTOINCREMENT,
            del_order INTEGER,
            del_fee REAL,
            del_delr_id INTEGER NOT NULL,
            FOREIGN KEY (del_delr_id) REFERENCES delivery_route (delr_id) ON DELETE CASCADE
          );
          ''',
        );
      },
    );
  }
}
