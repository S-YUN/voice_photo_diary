import 'package:voice_photo_diary/data/api/openai_api.dart';

class OpenAIApiMock implements OpenAIApi {
  @override
  Future<String> getImageDescription(String imagePath) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return 'This is a mock description of the image at $imagePath';
  }
}
