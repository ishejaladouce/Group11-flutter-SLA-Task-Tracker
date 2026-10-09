import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class StorageException implements Exception {
  final String message;
  const StorageException(this.message);

  @override
  String toString() => message;
}

class DatabaseService {
  DatabaseService._();
  static final DatabaseService instance = DatabaseService._();

  static const _dbname = 'tast_tracker.db';
  static const _tasksTable = 'tasks';

  Database? _db;

  /// opens the db the first time it's needed, then reuses it
  Future<Database> get _database async => _db ??= await _open();

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), _dbname);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tasksTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        priority TEXT NOT NULL,
        deadline TEXT NOT NULL,
        progress INTEGER NOT NULL
      )
    ''');
  }

  Future<T> _guard<T>(String action, Future<T> Function() run) async {
    try {
      return await run();
    } catch (_) {
      throw StorageException('Could not $action. Please try again.');
    }
  }

  Future<List<Task>> getTasks() => _guard('load tasks', () async {
    final db = await _database;
    final rows = await db.query(_tasksTable, orderBy: 'deadline ASC');
    return rows.map(Task.fromMap).toList();
  });

  Future<Task> insertTask(Task task) => _guard('save the task', () async {
    final db = await _database;
    final id = await db.insert(_tasksTable, task.toMap());
    return task.copyWith(id: id);
  });

  Future<Task> updateTask(Task task) => _guard('update the task', () async {
    final db = await _database;
    await db.update(
      _tasksTable,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    return task;
  });

  Future<void> deleteTask(int id) => _guard('delete the task', () async {
    final db = await _database;
    await db.delete(_tasksTable, where: 'id = ?', whereArgs: [id]);
  });

  Future<Task> saveTask(Task task) =>
    task.id == null ? insertTask(task) : updateTask(task);
}