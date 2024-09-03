import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voice_photo_diary/data/api/openai_api.dart';

class OpenAIApiImpl implements OpenAIApi {
  final String apiKey = 'your_openai_api_key_here';
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  @override
  Future<String> getImageDescription(String imagePath) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4-vision-preview',
        'messages': [
          {
            'role': 'user',
            'content': [
              {'type': 'text', 'text': 'Describe this image in detail.'},
              {
                'type': 'image_url',
                'image_url': {'url': imagePath}
              }
            ]
          }
        ],
        'max_tokens': 300
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get image description');
    }
  }
}
