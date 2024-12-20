import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';

class ProjectForm extends StatelessWidget {
  final Map<String, dynamic> formData;

  ProjectForm({required this.formData});

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: false);
    final _controllerName = TextEditingController(text: formData['nombre']);
    final _controllerProject = TextEditingController(text: formData['project']);
    final _controllerDescription = TextEditingController(text: formData['description']);
    final _controllerEmail = TextEditingController(text: formData['email']);

    void _saveData() {
      api.saveData({
        'nombre': _controllerName.text,
        'project': _controllerProject.text,
        'description': _controllerDescription.text,
        'email': _controllerEmail.text,
      });
    }

    return Card(
      child: Column(
        children: [
          TextField(controller: _controllerName),
          TextField(controller: _controllerProject),
          TextField(controller: _controllerDescription),
          TextField(controller: _controllerEmail),
          ElevatedButton(onPressed: _saveData, child: Text('Grabar')),
        ],
      ),
    );
  }
}
