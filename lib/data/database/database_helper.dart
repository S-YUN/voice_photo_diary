import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:voice_photo_diary/domain/model/photo_diary.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'photo_diary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE photo_diaries(
        id TEXT PRIMARY KEY,
        image_path TEXT NOT NULL,
        ai_description TEXT NOT NULL,
        user_description TEXT,
        created_at INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertPhotoDiary(PhotoDiary diary) async {
    final db = await database;
    await db.insert('photo_diaries', diary.toJson());
  }

  Future<List<PhotoDiary>> getAllPhotoDiaries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('photo_diaries', orderBy: 'created_at DESC');
    return List.generate(maps.length, (i) {
      return PhotoDiary.fromJson(maps[i]);
    });
  }

  Future<PhotoDiary?> getPhotoDiary(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'photo_diaries',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return PhotoDiary.fromJson(maps.first);
    }
    return null;
  }

  Future<void> updatePhotoDiary(PhotoDiary diary) async {
    final db = await database;
    await db.update(
      'photo_diaries',
      diary.toJson(),
      where: 'id = ?',
      whereArgs: [diary.id],
    );
  }

  Future<void> deletePhotoDiary(String id) async {
    final db = await database;
    await db.delete(
      'photo_diaries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
