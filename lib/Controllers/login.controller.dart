import 'package:flutter/material.dart';

class LoginController {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void dispose() {
    nomeController.dispose();
    emailController.dispose();
  }

  bool validarCampos() {
    return nomeController.text.isNotEmpty && emailController.text.isNotEmpty;
  }

  void confirmarLogin() {
    if (validarCampos()) {
      print('Nome: ${nomeController.text}');
      print('Email: ${emailController.text}');
    } else {
      print('Preencha todos os campos.');
    }
  }
}
