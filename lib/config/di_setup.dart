import 'package:get_it/get_it.dart';
import 'package:voice_photo_diary/data/api/openai_api.dart';
import 'package:voice_photo_diary/data/api/openai_api_impl.dart';
import 'package:voice_photo_diary/data/database/database_helper.dart';
import 'package:voice_photo_diary/data/database/photo_diary_dao/photo_diary_dao.dart';
import 'package:voice_photo_diary/data/database/photo_diary_dao/photo_diary_dao_impl.dart';
import 'package:voice_photo_diary/data/repository/photo_diary_repo_impl.dart';
import 'package:voice_photo_diary/domain/repository/photo_diary_repo.dart';
import 'package:voice_photo_diary/presentation/camera_photo/camera_photo_detail_view_model.dart';
import 'package:voice_photo_diary/presentation/home/home_screen_view_model.dart';
import 'package:voice_photo_diary/presentation/gallery/gallery_screen_view_model.dart';
import 'package:voice_photo_diary/presentation/my/my_screen_view_model.dart';
import 'package:voice_photo_diary/presentation/root/root_screen_view_model.dart';

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
  getIt.registerFactory(() => RootScreenViewModel());
  getIt.registerFactory(() => MyScreenViewModel());
  getIt.registerFactory(() => HomeScreenViewModel());
  getIt.registerFactory(() => GalleryScreenViewModel());
  getIt.registerFactory(() => CameraPhotoDetailViewModel());
}
