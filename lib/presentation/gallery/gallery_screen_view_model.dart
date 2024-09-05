import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryScreenViewModel with ChangeNotifier{

   List<AssetEntity> _mediaList = [];
  List<AssetEntity> get mediaList => _mediaList;

  Future<void> loadGalleryAssets() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      final albums = await PhotoManager.getAssetPathList(onlyAll: true);
      final recentAlbum = albums.first;
      final assetList = await recentAlbum.getAssetListRange(start: 0, end: 1000);
      _mediaList = assetList;
      notifyListeners();
    } else {
      // 권한이 없는 경우 처리
    }
  }

}