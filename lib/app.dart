import 'package:flutter/material.dart';
import 'package:voice_photo_diary/config/routers.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return MaterialApp.router(
      title: 'Voice Photo Diary',
      theme: ThemeData(
        useMaterial3: true,
        // primaryColor: ColorStyles.primary,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
    );
  }
}
