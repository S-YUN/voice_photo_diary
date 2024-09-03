import 'package:voice_photo_diary/domain/model/photo_diary.dart';

abstract interface class PhotoDiaryDao {
  Future<void> insertPhotoDiary(PhotoDiary diary);
  Future<List<PhotoDiary>> getAllPhotoDiaries();
  Future<PhotoDiary?> getPhotoDiary(String id);
  Future<void> updatePhotoDiary(PhotoDiary diary);
  Future<void> deletePhotoDiary(String id);
}
