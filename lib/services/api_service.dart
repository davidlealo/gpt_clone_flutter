import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _apiKey = dotenv.env['OPENAI_API_KEY']!;

  Future<String> sendPrompt(String prompt) async {
    final url = Uri.parse('https://api.openai.com/v1/completions');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'text-davinci-003',
          'prompt': prompt,
          'max_tokens': 150,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['text'].toString().trim();
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          'Error al conectar con la API: ${response.statusCode} - ${errorData['error']['message']}',
        );
      }
    } catch (e) {
      throw Exception('Error: No se pudo procesar la solicitud. $e');
    }
  }
}
