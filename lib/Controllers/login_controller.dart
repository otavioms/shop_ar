import 'package:flutter/material.dart';

class LoginController {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  void dispose() {
    emailController.dispose();
    senhaController.dispose();
  }

  bool confirmarLogin() {
    return emailController.text == 'admin@admin.com' && senhaController.text == '123456';
  }
}
