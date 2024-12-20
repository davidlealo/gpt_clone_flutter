import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'providers/form_data_provider.dart';

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

class GPTScreen extends StatefulWidget {
  @override
  _GPTScreenState createState() => _GPTScreenState();
}

class _GPTScreenState extends State<GPTScreen> {
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;

  void _sendPrompt() async {
    if (_promptController.text.isNotEmpty) {
      final prompt = _promptController.text;
      final formData = Provider.of<FormDataProvider>(context, listen: false);
      formData.addToChatHistory("Tú: $prompt");

      setState(() {
        _isLoading = true;
      });

      try {
        // Llamada a la API
        final apiService = Provider.of<ApiService>(context, listen: false);
        final result = await apiService.sendPrompt(prompt);

        // Actualizar el chat y el formulario
        formData.addToChatHistory("GPT: ${result['response']}");
        if (result['formData'] != null) {
          formData.fillFormFromPrompt(result['formData']);
        }
      } catch (e) {
        formData.addToChatHistory("Error: No se pudo obtener respuesta.");
      } finally {
        setState(() {
          _isLoading = false;
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
          // Mitad izquierda
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Chat
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.grey[200],
                    child: Consumer<FormDataProvider>(
                      builder: (context, formData, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chat:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView.builder(
                                itemCount: formData.chatHistory.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(
                                      formData.chatHistory[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // Campo de Prompt
                Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      TextField(
                        controller: _promptController,
                        decoration: InputDecoration(
                          hintText: 'Escribe tu prompt aquí...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _sendPrompt,
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text('Enviar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Mitad derecha
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[100],
              child: Consumer<FormDataProvider>(
                builder: (context, formData, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Formulario:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: formData.formData['nombre']),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Proyecto',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: formData.formData['project']),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Descripción',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: formData.formData['description']),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: formData.formData['email']),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para guardar datos en el backend
                          final apiService =
                              Provider.of<ApiService>(context, listen: false);
                          apiService.saveData(formData.formData);
                        },
                        child: Text('Enviar'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
