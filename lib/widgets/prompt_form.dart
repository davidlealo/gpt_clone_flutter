import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';

class PromptForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onFormFilled;

  PromptForm({required this.onFormFilled});

  @override
  _PromptFormState createState() => _PromptFormState();
}

class _PromptFormState extends State<PromptForm> {
  final _controller = TextEditingController();
  String _response = '';

  void _sendPrompt() async {
    final api = Provider.of<ApiService>(context, listen: false);
    final data = await api.sendPrompt(_controller.text);
    setState(() {
      _response = data['response'];
    });
    widget.onFormFilled(data['formData']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(controller: _controller),
          ElevatedButton(onPressed: _sendPrompt, child: Text('Enviar')),
          Text(_response),
        ],
      ),
    );
  }
}
