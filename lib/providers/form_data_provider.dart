import 'package:flutter/material.dart';

class FormDataProvider with ChangeNotifier {
  // Estado compartido
  Map<String, dynamic> _formData = {};

  // Getter para obtener los datos
  Map<String, dynamic> get formData => _formData;

  // Método para actualizar los datos
  void updateFormData(Map<String, dynamic> newFormData) {
    _formData = {..._formData, ...newFormData}; // Combina el nuevo con el existente
    notifyListeners(); // Notifica a los oyentes
  }

  // Método para reiniciar el formulario si es necesario
  void resetFormData() {
    _formData = {};
    notifyListeners();
  }
}
