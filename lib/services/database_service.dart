import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _userTable = 'user';
  final String _userIdColumn = 'id';
  final String _userFirstNameColumn = 'firstName';
  final String _userLastNameColumn = 'lastName';
  final String _userAgeColumn = 'age';
  final String _userGenderColumn = 'gender';
  final String _userMailColumn = 'mail';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();

    final databasePath = join(databaseDirPath, "test_db.db");
    try {
      final database =
          await openDatabase(databasePath, version: 1, onCreate: (db, version) {
        db.execute('''
          CREATE TABLE user (
            id TEXT PRIMARY KEY,
            firstName TEXT,
            lastName TEXT,
            age TEXT,
            gender TEXT,
            mail TEXT
          )
        ''');
        //       db.execute('''
        // CREATE TABLE $_userTable(
        //   $_userIdColumn TEXT PRIMARY KEY,
        //   $_userFirstNameColumn TEXT,
        //   $_userLastNameColumn TEXT,
        //   $_userAgeColumn TEXT,
        //   $_userGenderColumn TEXT,
        //   $_userMailColumn TEXT,
        //   )''');
      });
    } catch (e) {
      print("object");
      // TODO
    }
    return database;
  }

  void addUser(String userId, String firstName, String lastName, String age,
      String gender, String mail) async {
    final db = await database;
    await db.insert(_userTable, {
      _userIdColumn: userId,
      _userFirstNameColumn: firstName,
      _userLastNameColumn: lastName,
      _userAgeColumn: age,
      _userGenderColumn: gender,
      _userMailColumn: mail
    });
  }

  Future<List<User>> getUser() async {
    final db = await database;
    final data = await db.query(_userTable);
    List<User> users = data
        .map((e) => User(
            id: e['id'] as String,
            firstName: e["firstName"] as String,
            lastName: e["lastName"] as String,
            age: e["age"] as String,
            gender: e["gender"] as String,
            mail: e["mail"] as String))
        .toList();
    return users;
  }
}
