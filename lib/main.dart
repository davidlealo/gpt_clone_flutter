import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/api_service.dart';

Future<void> main() async {
  await dotenv.load(); // Cargar las variables de entorno desde .env
  runApp(MyApp());
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

class GPTScreen extends StatefulWidget {
  @override
  _GPTScreenState createState() => _GPTScreenState();
}

class _GPTScreenState extends State<GPTScreen> {
  final TextEditingController _promptController = TextEditingController();
  final List<String> _chatHistory = [];
  bool _isLoading = false; // Para mostrar un indicador de carga

  void _sendPrompt() async {
  if (_promptController.text.isNotEmpty) {
    final prompt = _promptController.text;
    setState(() {
      _chatHistory.add("Tú: $prompt");
      _isLoading = true; // Mostrar indicador de carga
    });

    try {
      // Llamada a la API de OpenAI
      final result = await ApiService().sendPrompt(prompt);
      final responseText = result['response']; // Extrae solo el texto de la respuesta
      setState(() {
        _chatHistory.add("GPT: $responseText");
      });
    } catch (e) {
      setState(() {
        _chatHistory.add("Error: No se pudo obtener respuesta.");
      });
    } finally {
      setState(() {
        _isLoading = false; // Ocultar indicador de carga
      });
      _promptController.clear();
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clone GPTs'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Columna Izquierda: Formulario
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enviar un prompt:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _promptController,
                    decoration: InputDecoration(
                      hintText: 'Escribe tu prompt aquí...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _sendPrompt, // Deshabilitar mientras carga
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
          // Columna Derecha: Chat
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chat:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _chatHistory.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            _chatHistory[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
