import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:voice_photo_diary/presentation/gallery/gallery_screen_view_model.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GalleryScreenViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('갤러리')),
      body: FutureBuilder<void>(
        future: viewModel.loadGalleryAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: viewModel.mediaList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => context.go('/photo-detail/${viewModel.mediaList[index].id}'),
                child: AssetEntityImage(
                  viewModel.mediaList[index],
                  isOriginal: false,
                  thumbnailSize: const ThumbnailSize.square(200),
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
    );
  }
}