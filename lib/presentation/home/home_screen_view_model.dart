import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  Future<void> takePictureByCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    
  }
}