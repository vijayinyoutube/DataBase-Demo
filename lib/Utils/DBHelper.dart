import 'dart:async';
import 'dart:io' as io;
import 'package:bottomsheet/Models/HomePageModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String TEXT = 'text';
  static const String TABLE = 'Text';
  static const String DB_NAME = 'TEXTDB';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TEXT TEXT)");
  }

  Future<MyText> insertText(MyText myText) async {
    var dbClient = await db;
    myText.id = await dbClient.insert(TABLE, myText.toMap());
    return myText;
  }

  Future<List<MyText>> getText() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [
      ID,
      TEXT,
    ]);

    List<MyText> myText = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        myText.add(MyText.fromMap(maps[i]));
      }
    }
    return myText;
  }
}
