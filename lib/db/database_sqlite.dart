import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:todolist_flutter/model/todo_model.dart';

class SQLHelper {
  static final DATABASE_NAME = "TODO_LIST";
  static final VERSTION = 1;
  static final NAME_TABLE = "TodoTable";

  static final Id = "id";
  static final Title = "title";
  static final createdAt = "createdAt";
  static final isComplete = "isComplete";

  static Future<void> createTables(sql.Database database) async {
    String createTableQuery = "CREATE TABLE " +
        NAME_TABLE +
        "(" +
        Id +
        " INTEGER PRIMARY KEY AUTOINCREMENT ," +
        Title +
        " TEXT," +
        createdAt +
        " TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP," +
        isComplete +
        " BIT " +
        ")";

    await database.execute(createTableQuery);
  }

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

  Future<int> insertTodo(String title, int fav) async {
    final db = await SQLHelper.db();

    final data = {
      Title: title,
      createdAt: DateTime.now().toString(),
      isComplete: fav
    };
    final id = await db.insert(NAME_TABLE, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Map<String, dynamic>>> getAllTodo() async {
    final db = await SQLHelper.db();
    return await db.query(NAME_TABLE, orderBy: "id");
    //debugPrint("fahamin" + maps.toString());
    //return List<TodoModel>.from(maps.map((map) => TodoModel.fromMap(map)));
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getTodoByID(int id) async {
    final db = await SQLHelper.db();
    return db.query(NAME_TABLE, where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  Future<int> updateTodo(int id, String title, int fav) async {
    final db = await SQLHelper.db();

    final data = {
      Title: title,
      createdAt: DateTime.now().toString(),
      isComplete: fav
    };

    final result =
        await db.update(NAME_TABLE, data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  Future<void> deleteTodo(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(NAME_TABLE, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}
