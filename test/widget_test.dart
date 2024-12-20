import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:gpt_clone_flutter/main.dart';
import 'package:gpt_clone_flutter/services/api_service.dart';
import 'package:gpt_clone_flutter/widgets/prompt_form.dart';

void main() {
  testWidgets('PromptForm renders and processes input', (WidgetTester tester) async {
    // Simular un ApiService para pruebas
    final mockApiService = MockApiService();

    // Renderizar la app con Provider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<ApiService>.value(value: mockApiService),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: PromptForm(
              onFormFilled: (formData) {
                // Este callback puede verificarse si es necesario
                expect(formData['nombre'], 'Ejemplo');
              },
            ),
          ),
        ),
      ),
    );

    // Verificar que el widget PromptForm está presente
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Enviar'), findsOneWidget);

    // Simular entrada de texto
    await tester.enterText(find.byType(TextField), 'Prueba de prompt');
    await tester.tap(find.text('Enviar'));
    await tester.pump();

    // Verificar que la respuesta del modelo se muestra en la interfaz
    expect(find.textContaining('Simulación de respuesta'), findsOneWidget);
  });
}

// Mock del ApiService para evitar llamadas reales a la API
class MockApiService implements ApiService {
  @override
  Future<Map<String, dynamic>> sendPrompt(String prompt) async {
    return {
      'response': 'Simulación de respuesta para: $prompt',
      'formData': {'nombre': 'Ejemplo', 'project': 'Proyecto 1'},
    };
  }

  @override
  Future<void> saveData(Map<String, dynamic> formData) async {
    // Simular guardado sin errores
  }
}
