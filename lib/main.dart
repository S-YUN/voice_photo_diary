import 'package:flutter/material.dart';
import 'package:voice_photo_diary/app.dart';
import 'package:voice_photo_diary/config/di_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}
