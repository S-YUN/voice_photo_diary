import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_photo_diary/presentation/root/root_screen_view_model.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RootScreenViewModel>();
    return Scaffold(
      body: PageView(
        controller: viewModel.pageController,
        onPageChanged: viewModel.onPageChanged,
        children: viewModel.screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.changeIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '일기 쓰기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '저장된 일기',
          ),
        ],
      ),
    );
  }
}