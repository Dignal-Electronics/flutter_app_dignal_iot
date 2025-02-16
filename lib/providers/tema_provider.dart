import 'package:flutter/material.dart';

class TemaProvider with ChangeNotifier {
  bool _modoLight = true;

  bool get modoLight => _modoLight;

  set modoLight(bool valor) {
    _modoLight = valor;
    notifyListeners();
  }
}
