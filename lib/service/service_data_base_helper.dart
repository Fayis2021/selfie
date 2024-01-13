import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user_data_model.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'my_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE my_table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imageAddress TEXT,
        lat REAL,
        long REAL
      )
    ''');
  }

  Future<int> insert(MyDataModel myDataModel) async {
    final Database db = await instance.database;
    return await db.insert('my_table', myDataModel.toMap());
  }

  Future<List<MyDataModel>> getAllData() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('my_table');

    return List.generate(
      maps.length,
      (index) {
        return MyDataModel(
          imageAddress: maps[index]['imageAddress'],
          lat: maps[index]['lat'],
          long: maps[index]['long'],
        );
      },
    );
  }
}
