import 'package:firebase_application_1/userModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database db;

  static final int _version = 1;
  static final String _tableName = 'user';

  static Future<void> initDb() async {
    if (db != null) {
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'user.db';
        db = await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version) {
            return db.execute(
              "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT,password TEXT, mobile TEXT, address TEXT)",
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(UserModel user) async {
    print("insert function called $user");

    var b = await db.rawInsert(
        'INSERT INTO $_tableName (name, mobile, address) VALUES(?, ?, ?)',
        [user.name, user.mobile, user.address]);
    print(b);
    var c = await db.insert(_tableName, user.toJson());
    print(c);
    return c;
  }

  static Future<String> delete(UserModel user) async {
    var a = await db.delete(_tableName, where: 'id = ?', whereArgs: [user.id]);
    if (a == 1) {
      return "ok";
    }

    return " not Ok ";
  }

  static Future<List<Map<String, dynamic>>> userList() async {
    print("query function called");
    return db.query(_tableName);
  }

  static Future<int> update(UserModel userModel) async {
    print("update function called");
    var u = await db.update(_tableName, userModel.toJson());
    // return await db.rawUpdate('''
    // UPDATE user
    // SET mobile = ?
    // WHERE id = ?
    // ''', [1, id]);
    //
    return u;
  }
}
