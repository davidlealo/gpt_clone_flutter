import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../providers/form_data_provider.dart';

class PromptForm extends StatefulWidget {
  @override
  _PromptFormState createState() => _PromptFormState();
}

class _PromptFormState extends State<PromptForm> {
  final _controller = TextEditingController();
  String _response = '';

  void _sendPrompt() async {
    if (_controller.text.isNotEmpty) {
      final api = Provider.of<ApiService>(context, listen: false);
      try {
        final data = await api.sendPrompt(_controller.text);

        // Actualiza el estado global con los datos recibidos
        Provider.of<FormDataProvider>(context, listen: false)
            .updateFormData(data['formData'] ?? {});

        setState(() {
          _response = data['response']; // Actualiza la respuesta localmente
        });
      } catch (e) {
        setState(() {
          _response = 'Error al enviar el prompt: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Formulario de Prompt:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Escribe tu prompt aquí',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendPrompt,
              child: Text('Enviar'),
            ),
            SizedBox(height: 10),
            Text(
              'Respuesta:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
