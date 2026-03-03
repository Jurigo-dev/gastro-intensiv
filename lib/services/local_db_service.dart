import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/mood_entry.dart';

class LocalDbService {
  static const _table = 'mood_entries';
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    _db = await openDatabase(
      join(dbPath, 'mood_forecaster.db'),
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE $_table(
            id TEXT PRIMARY KEY,
            timestamp TEXT,
            moodScore INTEGER,
            energyScore INTEGER,
            stressScore INTEGER,
            note TEXT,
            steps INTEGER,
            sleepHours REAL
          )
        ''');
      },
    );
    return _db!;
  }

  Future<void> insertEntry(MoodEntry entry) async {
    final db = await database;
    await db.insert(_table, entry.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MoodEntry>> getEntries() async {
    final db = await database;
    final maps = await db.query(_table, orderBy: 'timestamp DESC');
    return maps.map(MoodEntry.fromMap).toList();
  }
}
