import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voice_photo_diary/config/di_setup.dart';

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return ChangeNotifierProvider(
            create: (context) => getIt<HomeViewModel>(),
            child: const HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: '/diary/:id',
        builder: (BuildContext context, GoRouterState state) {
          final id = state.pathParameters['id']!;
          return ChangeNotifierProvider(
            create: (context) => getIt<DiaryViewModel>(),
            child: DiaryDetailScreen(diaryId: id),
          );
        },
      ),
    ],
  );
}
