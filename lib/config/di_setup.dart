import 'package:get_it/get_it.dart';
import 'package:voice_photo_diary/data/api/openai_api.dart';
import 'package:voice_photo_diary/data/api/openai_api_impl.dart';
import 'package:voice_photo_diary/data/database/database_helper.dart';
import 'package:voice_photo_diary/data/database/photo_diary_dao/photo_diary_dao.dart';
import 'package:voice_photo_diary/data/database/photo_diary_dao/photo_diary_dao_impl.dart';
import 'package:voice_photo_diary/data/repository/photo_diary_repo_impl.dart';
import 'package:voice_photo_diary/domain/repository/photo_diary_repo.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Database
  getIt.registerSingletonAsync<DatabaseHelper>(() async {
    final databaseHelper = DatabaseHelper();
    await databaseHelper.database;
    return databaseHelper;
  });

  //dao
  getIt.registerSingletonWithDependencies<PhotoDiaryDao>(
    () => PhotoDiaryDaoImpl(getIt<DatabaseHelper>()),
    dependsOn: [DatabaseHelper],
  );

  // API
  getIt.registerLazySingleton<OpenAIApi>(() => OpenAIApiImpl());

  // Repository
  getIt.registerLazySingleton<PhotoDiaryRepository>(
    () => PhotoDiaryRepositoryImpl(getIt<OpenAIApi>(), getIt<PhotoDiaryDao>()),
  );

  // ViewModels
}
