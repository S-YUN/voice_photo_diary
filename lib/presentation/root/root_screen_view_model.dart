import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_photo_diary/config/di_setup.dart';
import 'package:voice_photo_diary/presentation/home/home_screen.dart';
import 'package:voice_photo_diary/presentation/home/home_screen_view_model.dart';
import 'package:voice_photo_diary/presentation/my/my_screen.dart';
import 'package:voice_photo_diary/presentation/my/my_screen_view_model.dart';

class RootScreenViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  late PageController pageController;
  List<Widget> screens = [];

  RootScreenViewModel() {
    pageController = PageController(initialPage: _currentIndex);
    screens = [
      ChangeNotifierProvider(
        create: (context) => getIt<HomeScreenViewModel>(),
        child: const HomeScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => getIt<MyScreenViewModel>(),
        child: const MyScreen(),
      ),
    ];
  }

  void changeIndex(int index) {
    _currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}