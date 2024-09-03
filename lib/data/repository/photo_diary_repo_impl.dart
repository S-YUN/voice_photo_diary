import 'package:uuid/uuid.dart';
import 'package:voice_photo_diary/data/api/openai_api.dart';
import 'package:voice_photo_diary/data/database/photo_diary_dao/photo_diary_dao.dart';
import 'package:voice_photo_diary/domain/model/photo_diary.dart';
import 'package:voice_photo_diary/domain/repository/photo_diary_repo.dart';

class PhotoDiaryRepositoryImpl implements PhotoDiaryRepository {
  final OpenAIApi _openAIApi;
  final PhotoDiaryDao _photoDiaryDao;

  PhotoDiaryRepositoryImpl(this._openAIApi, this._photoDiaryDao);

  @override
  Future<void> addPhotoDiary(String imagePath) async {
    final aiDescription = await _openAIApi.getImageDescription(imagePath);
    final photoDiary = PhotoDiary(
      id: const Uuid().v4(),
      imagePath: imagePath,
      aiDescription: aiDescription,
      createdAt: DateTime.now(),
    );
    await _photoDiaryDao.insertPhotoDiary(photoDiary);
  }

  @override
  Future<List<PhotoDiary>> getAllPhotoDiaries() async {
    return await _photoDiaryDao.getAllPhotoDiaries();
  }

  @override
  Future<PhotoDiary?> getPhotoDiary(String id) async {
    return await _photoDiaryDao.getPhotoDiary(id);
  }

  @override
  Future<void> updateUserDescription(String id, String description) async {
    final diary = await _photoDiaryDao.getPhotoDiary(id);
    if (diary != null) {
      final updatedDiary = diary.copyWith(userDescription: description);
      await _photoDiaryDao.updatePhotoDiary(updatedDiary);
    }
  }

  @override
  Future<void> deletePhotoDiary(String id) async {
    await _photoDiaryDao.deletePhotoDiary(id);
  }
}
