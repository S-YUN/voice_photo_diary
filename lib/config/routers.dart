import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voice_photo_diary/config/di_setup.dart';
import 'package:voice_photo_diary/presentation/gallery/gallery_screen.dart';
import 'package:voice_photo_diary/presentation/gallery/gallery_screen_view_model.dart';
import 'package:voice_photo_diary/presentation/root/root_screen.dart';
import 'package:voice_photo_diary/presentation/root/root_screen_view_model.dart';

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return ChangeNotifierProvider(
            create: (context) => getIt<RootScreenViewModel>(),
            child: const RootScreen(),
          );
        },
      ),
      GoRoute(
        path: '/gallery',
        builder: (BuildContext context, GoRouterState state) {
          return ChangeNotifierProvider(
            create: (context) => getIt<GalleryScreenViewModel>(),
            child: const GalleryScreen(),
          );
        },
      ),
      GoRoute(
        path: '/camera-photo-detail',
        builder: (BuildContext context, GoRouterState state) {
          return ChangeNotifierProvider(
            create: (context) => getIt<GalleryScreenViewModel>(),
            child: const GalleryScreen(),
          );
        },
      ),
      
    ],
  );
}
