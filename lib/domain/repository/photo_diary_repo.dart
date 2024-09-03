import 'package:voice_photo_diary/domain/model/photo_diary.dart';

abstract interface class PhotoDiaryRepository {
  Future<void> addPhotoDiary(String imagePath);
  Future<List<PhotoDiary>> getAllPhotoDiaries();
  Future<PhotoDiary?> getPhotoDiary(String id);
  Future<void> updateUserDescription(String id, String description);
  Future<void> deletePhotoDiary(String id);
}
