import 'package:flutter/material.dart';

class EstadosProvider with ChangeNotifier {
  bool _activo = true;

  bool get activo => _activo;

  set activo(bool value) {
    _activo = value;
    notifyListeners();
  }

  String titulo = "";

  List<Map<String, String>> alumnos = [];
}
