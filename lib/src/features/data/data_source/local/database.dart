import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/todo/todo_model.dart';
import '../../models/todo/todo_model_fields.dart';

class LocalDataBase {
  LocalDataBase._();
  static final LocalDataBase instance = LocalDataBase._();
  factory LocalDataBase() => instance;

  static Database? _dataBase;

  Future<Database> _init() async {
    if (_dataBase != null) return _dataBase!;
    return _dataBase = await _initDB('todo.db');
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database database, int version) async {
    await database.execute('''
    CREATE TABLE ${TodoModelSQL.tableName} (
      ${TodoModelSQL.id} ${TodoModelSQL.idType},
      ${TodoModelSQL.eventName} ${TodoModelSQL.textType},
      ${TodoModelSQL.eventDesc} ${TodoModelSQL.textType},
      ${TodoModelSQL.eventLocation} ${TodoModelSQL.textType},
      ${TodoModelSQL.priorityColor} ${TodoModelSQL.textType},
      ${TodoModelSQL.eventTime} ${TodoModelSQL.textType},
      ${TodoModelSQL.eventDate} ${TodoModelSQL.textType}
    ) ''');
  }

  Future<int> insertTodo(TodoModel todoModel) async {
    final db = await instance._init();
    return await db.insert(TodoModelSQL.tableName, todoModel.toJson());
  }

  Future<List<TodoModel>> getTodosByDate(String selectedDate) async {
    final db = await instance._init();
    final todos = await db.query(
      TodoModelSQL.tableName,
      where: 'event_date = ?',
      whereArgs: [
        selectedDate,
      ],
    );
    return todos.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<List<TodoModel>> getTodos() async {
    final db = await instance._init();
    final todos = await db.query(TodoModelSQL.tableName);
    return todos.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<int> deleteById(int id) async {
    final db = await instance._init();
    return await db.delete(
      TodoModelSQL.tableName,
      where: '_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> edit({
    required int id,
    required TodoModel todoModel,
  }) async {
    final db = await instance._init();
    return await db.update(
      TodoModelSQL.tableName,
      todoModel.toJson(),
      where: '_id = ?',
      whereArgs: [id],
    );
  }
}
