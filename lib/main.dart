import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'widgets/prompt_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (_) => ApiService())],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Clone GPTs')),
          body: PromptForm(
            onFormFilled: (data) {
              // Navegar a ProjectForm (puedes manejar esto con rutas si deseas)
            },
          ),
        ),
      ),
    );
  }
}
