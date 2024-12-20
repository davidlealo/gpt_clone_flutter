import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _apiKey = dotenv.env['OPENAI_API_KEY']!;

  // Método para enviar prompts a OpenAI
  Future<Map<String, dynamic>> sendPrompt(String prompt) async {
    final url = Uri.parse(
        'https://api.openai.com/v1/chat/completions'); // Endpoint de chat completions

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo', // Modelo utilizado
          'messages': [
            {'role': 'user', 'content': prompt}, // Formato para mensajes
          ],
          'max_tokens': 150,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final responseText =
            data['choices'][0]['message']['content'].toString().trim();

        // Extraer datos del formulario
        final formData = _extractFormData(responseText);

        return {
          'response': responseText,
          'formData': formData, // Datos extraídos
          'status': response.statusCode,
        };
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

  // Método para guardar datos en el backend
  Future<void> saveData(Map<String, dynamic> formData) async {
    final url =
        Uri.parse('http://localhost:8080/api/save'); // Ajusta según tu backend

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(formData),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Error al guardar datos: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error al intentar guardar los datos: $e');
    }
  }

  // Método privado para extraer datos del formulario del texto de respuesta
  Map<String, String> _extractFormData(String responseText) {
    final extractedData = <String, String>{};

    final nameMatch =
        RegExp(r'nombre:\s*(.*)', caseSensitive: false).firstMatch(responseText);
    final projectMatch = RegExp(r'proyecto:\s*(.*)', caseSensitive: false)
        .firstMatch(responseText);
    final descriptionMatch = RegExp(r'descripción:\s*(.*)', caseSensitive: false)
        .firstMatch(responseText);
    final emailMatch = RegExp(r'email:\s*([\w\.\-]+@[a-zA-Z]+\.[a-zA-Z]+)',
            caseSensitive: false)
        .firstMatch(responseText);

    extractedData['nombre'] = nameMatch?.group(1)?.trim() ?? '';
    extractedData['project'] = projectMatch?.group(1)?.trim() ?? '';
    extractedData['description'] = descriptionMatch?.group(1)?.trim() ?? '';
    extractedData['email'] = emailMatch?.group(1)?.trim() ?? '';

    return extractedData;
  }
}
