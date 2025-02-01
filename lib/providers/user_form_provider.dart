import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/models/models.dart';

class UserFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserFormProvider(this.user);

  User user;

  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }
}
