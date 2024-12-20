import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'providers/form_data_provider.dart';
import 'widgets/prompt_form.dart';
import 'widgets/chat_display.dart';

Future<void> main() async {
  await dotenv.load(); // Cargar las variables de entorno desde .env
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormDataProvider()),
        Provider(create: (_) => ApiService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clone GPTs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: GPTScreen(),
    );
  }
}

class GPTScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clone GPTs'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Formulario en la parte superior
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: PromptForm(), // Widget modular del formulario
            ),
          ),
          Divider(height: 1, color: Colors.grey), // Línea divisoria
          // Chat en la parte inferior
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: ChatDisplay(), // Widget modular del chat
            ),
          ),
        ],
      ),
    );
  }
}
