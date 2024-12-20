import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'http://localhost:8080/', // Cambia si usas otro puerto
            headers: {'Content-Type': 'application/json'},
          ),
        );

  /// Envía un prompt al backend y obtiene la respuesta.
  Future<Map<String, dynamic>> sendPrompt(String prompt) async {
    try {
      final response = await _dio.post(
        '/api/mistral',
        data: {'prompt': prompt},
      );

      return response.data;
    } on DioException catch (e) {
      print('Error al enviar el prompt: ${e.message}');
      return {'error': 'No se pudo procesar el prompt.'};
    }
  }

  /// Guarda los datos del formulario en el backend.
  Future<void> saveData(Map<String, dynamic> formData) async {
    try {
      await _dio.post(
        '/api/save',
        data: formData,
      );
    } on DioException catch (e) {
      print('Error al guardar los datos: ${e.message}');
    }
  }
}
