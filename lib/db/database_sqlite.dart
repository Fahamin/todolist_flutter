
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:todolist_flutter/model/todo_model.dart';

class SQLHelper {
  static final DATABASE_NAME = "databaseTV";
  static final VERSTION = 1;
  static final CHANNEL_TABLE = "channelTable";

  static final ID = "id";
  static final TITLE = "title";
  static final createdAt = "createdAt";
  static final isComplete = "isComplete";



  static Future<void> createTables(sql.Database database) async {
    String CREATE_TABLE_QUERY = "CREATE TABLE " +
        CHANNEL_TABLE +
        "(" +
        ID +
        " INTEGER PRIMARY KEY AUTOINCREMENT ," +
        TITLE +
        " TEXT," +
        createdAt +
        " TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP," +
        isComplete +
        " BIT " +
        ")";



    await database.execute(CREATE_TABLE_QUERY);


    /* await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);*/
  }

// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    var databasesPath = await getDatabasesPath();
    return await sql.openDatabase(
      DATABASE_NAME,
      version: VERSTION,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> insertTodo(
      String title,  int fav) async {
    final db = await SQLHelper.db();

    final data = {TITLE: title, createdAt: DateTime.now().toString(),  isComplete: fav};
    final id = await db.insert(CHANNEL_TABLE, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  List<TodoModel> channelList = [];

  Future<List<TodoModel>> getAllTodo() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(CHANNEL_TABLE, orderBy: "id");

    return List<TodoModel>.from(maps.map((map) => TodoModel.fromMap(map)));

  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItemByID(int id) async {
    final db = await SQLHelper.db();
    return db.query(CHANNEL_TABLE, where: "id = ?", whereArgs: [id], limit: 1);
  }




  // Update an item by id
  static Future<int> updateTodo(int id, String title, int fav) async {
    final db = await SQLHelper.db();

    final data = {
      TITLE: title,
      createdAt: DateTime.now().toString(),
      isComplete: fav
    };

    final result =
        await db.update(CHANNEL_TABLE, data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteTodo(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(CHANNEL_TABLE, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }

}
