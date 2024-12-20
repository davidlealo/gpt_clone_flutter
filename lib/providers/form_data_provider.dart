import 'package:flutter/material.dart';

class FormDataProvider with ChangeNotifier {
  // Estado compartido para los datos del formulario
  Map<String, dynamic> _formData = {};

  // Estado compartido para el historial del chat
  final List<String> _chatHistory = [];

  // Getters
  Map<String, dynamic> get formData => _formData;
  List<String> get chatHistory => _chatHistory;

  // Actualiza los datos del formulario con nuevos valores
  void updateFormData(Map<String, dynamic> newFormData) {
    _formData = {..._formData, ...newFormData};
    notifyListeners(); // Notifica a los oyentes
  }

  // Rellenar automáticamente el formulario desde un prompt
  void fillFormFromPrompt(Map<String, String> extractedData) {
    _formData = {..._formData, ...extractedData};
    notifyListeners();
  }

  // Agrega un mensaje al historial del chat
  void addToChatHistory(String message) {
    _chatHistory.add(message);
    notifyListeners(); // Notifica a los oyentes
  }

  // Reinicia el historial del chat y los datos del formulario
  void resetData() {
    _formData = {};
    _chatHistory.clear();
    notifyListeners(); // Notifica a los oyentes
  }
}
