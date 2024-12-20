import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_data_provider.dart';
import '../services/api_service.dart';

class PromptForm extends StatefulWidget {
  @override
  _PromptFormState createState() => _PromptFormState();
}

class _PromptFormState extends State<PromptForm> {
  final _promptController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  void _sendPrompt() async {
    if (_promptController.text.isNotEmpty) {
      final prompt = _promptController.text;
      final description = _descriptionController.text;
      final formData = Provider.of<FormDataProvider>(context, listen: false);

      formData.addToChatHistory("Tú: $prompt");

      setState(() {
        _isLoading = true;
      });

      try {
        final apiService = Provider.of<ApiService>(context, listen: false);
        final result = await apiService.sendPrompt(prompt);
        formData.addToChatHistory("GPT: ${result['response']}");
      } catch (e) {
        formData.addToChatHistory("Error: No se pudo obtener respuesta.");
      } finally {
        setState(() {
          _isLoading = false;
        });
        _promptController.clear();
        _descriptionController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Formulario:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _promptController,
          decoration: InputDecoration(
            labelText: 'Prompt',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: 'Descripción',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _isLoading ? null : _sendPrompt,
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text('Enviar'),
        ),
      ],
    );
  }
}
