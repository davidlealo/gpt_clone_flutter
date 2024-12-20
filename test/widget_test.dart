import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:gpt_clone_flutter/widgets/prompt_form.dart';
import 'package:gpt_clone_flutter/providers/form_data_provider.dart';
import 'package:gpt_clone_flutter/services/api_service.dart';

void main() {
  testWidgets('PromptForm renders and processes input with Provider',
      (WidgetTester tester) async {
    // Simular un ApiService para pruebas
    final mockApiService = MockApiService();

    // Renderizar la app con MultiProvider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FormDataProvider()),
          Provider<ApiService>.value(value: mockApiService),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: PromptForm(),
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
    expect(find.textContaining('Simulación de respuesta para: Prueba de prompt'),
        findsOneWidget);

    // Verificar que los datos se actualizan en el FormDataProvider
    final formDataProvider =
        tester.state(find.byType(PromptForm)) as FormDataProvider;
    expect(formDataProvider.formData['nombre'], 'Ejemplo');
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
