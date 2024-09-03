import 'package:sqflite/sqflite.dart';
import 'package:voice_photo_diary/data/database/database_helper.dart';
import 'package:voice_photo_diary/data/database/photo_diary_dao/photo_diary_dao.dart';
import 'package:voice_photo_diary/domain/model/photo_diary.dart';

class PhotoDiaryDaoImpl implements PhotoDiaryDao {
  final DatabaseHelper _dbHelper;

  PhotoDiaryDaoImpl(this._dbHelper);

  Future<Database> get _db async => await _dbHelper.database;

  @override
  Future<void> insertPhotoDiary(PhotoDiary diary) async {
    final db = await _db;
    await db.insert('photo_diaries', diary.toJson());
  }

  @override
  Future<List<PhotoDiary>> getAllPhotoDiaries() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps =
        await db.query('photo_diaries', orderBy: 'created_at DESC');
    return List.generate(maps.length, (i) {
      return PhotoDiary.fromJson(maps[i]);
    });
  }

  @override
  Future<PhotoDiary?> getPhotoDiary(String id) async {
    final db = await _db;
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

  @override
  Future<void> updatePhotoDiary(PhotoDiary diary) async {
    final db = await _db;
    await db.update(
      'photo_diaries',
      diary.toJson(),
      where: 'id = ?',
      whereArgs: [diary.id],
    );
  }

  @override
  Future<void> deletePhotoDiary(String id) async {
    final db = await _db;
    await db.delete(
      'photo_diaries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
