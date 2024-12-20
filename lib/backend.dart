import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final router = Router();

  // Endpoint para manejar prompts
  router.post('/api/mistral', (Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);

    final prompt = data['prompt'];
    final response = {
      'response': 'Respuesta generada para: $prompt',
      'formData': {
        'nombre': 'Usuario',
        'project': 'Nuevo Proyecto',
        'description': 'Descripción generada',
        'email': 'usuario@ejemplo.com',
      },
    };

    return Response.ok(
      jsonEncode(response),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // Endpoint para guardar datos
  router.post('/api/save', (Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);

    print('Datos recibidos: $data');
    return Response.ok(
      jsonEncode({'message': 'Datos guardados exitosamente'}),
      headers: {'Content-Type': 'application/json'},
    );
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  final server = await io.serve(handler, 'localhost', 8080);
  print('Servidor escuchando en http://${server.address.host}:${server.port}');
}
