import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'photo_diary.freezed.dart';
part 'photo_diary.g.dart';

@freezed
class PhotoDiary with _$PhotoDiary {
  const PhotoDiary._(); // 이를 추가하여 커스텀 메서드를 사용할 수 있게 합니다.

  const factory PhotoDiary({
    required String id,
    required String imagePath,
    required String aiDescription,
    String? userDescription,
    required DateTime createdAt,
  }) = _PhotoDiary;

  factory PhotoDiary.create({
    required String imagePath,
    required String aiDescription,
    String? userDescription,
  }) {
    return PhotoDiary(
      id: const Uuid().v4(),
      imagePath: imagePath,
      aiDescription: aiDescription,
      userDescription: userDescription,
      createdAt: DateTime.now(),
    );
  }

  factory PhotoDiary.fromJson(Map<String, dynamic> json) =>
      _$PhotoDiaryFromJson(json);
}
