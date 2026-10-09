import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DatabaseService {
  DatabaseService._();
  static final DatabaseService instance = DatabaseService._();

  static const _dbname = 'tast_tracker.db';
  static const _taskTable = 'tasks';

  Database? _db;

  /// opens the db the first time it's needed, then reuses it
  Future<Database> get _database async => _db ??= await _open();

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), _dbname);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_taskTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        priority TEXT NOT NULL,
        deadline TEXT NOT NULL,
        progress INTEGER NOT NULL
      )
    ''');
  }

  Future<List<Task>> getTasks() async {
    final db = await _database;
    final rows = await db.query(_taskTable, orderBy: 'deadline ASC');
    return rows.map(Task.fromMap).toList();
  }

  Future<Task> insertTask(Task task) async {
    final db = await _database;
    final id = await db.insert(_taskTable, task.toMap());
    return task.copyWith(id: id);
  }
}