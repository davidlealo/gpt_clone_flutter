import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../providers/form_data_provider.dart';

class ProjectForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: false);
    final formData = Provider.of<FormDataProvider>(context); // Estado global

    // Controladores con datos iniciales desde el estado global
    final _controllerName = TextEditingController(text: formData.formData['nombre'] ?? '');
    final _controllerProject = TextEditingController(text: formData.formData['project'] ?? '');
    final _controllerDescription = TextEditingController(text: formData.formData['description'] ?? '');
    final _controllerEmail = TextEditingController(text: formData.formData['email'] ?? '');

    void _saveData() {
      // Actualizar estado global
      formData.updateFormData({
        'nombre': _controllerName.text,
        'project': _controllerProject.text,
        'description': _controllerDescription.text,
        'email': _controllerEmail.text,
      });

      // Guardar datos en el backend
      api.saveData(formData.formData);
    }

    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Formulario del Proyecto:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controllerName,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controllerProject,
              decoration: InputDecoration(
                labelText: 'Proyecto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controllerDescription,
              decoration: InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controllerEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Grabar'),
            ),
          ],
        ),
      ),
    );
  }
}
