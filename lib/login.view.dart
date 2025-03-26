import 'package:flutter/material.dart';
import 'login.controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _controller = LoginController();

  TextField criarCaixaEdicao({
    required TextEditingController controlador,
    required String rotulo,
    String dica = '',
  }) {
    return TextField(
      controller: controlador,
      decoration: InputDecoration(
        labelText: rotulo,
        border: OutlineInputBorder(),
        hintText: dica,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entrada de Dados')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            criarCaixaEdicao(
              controlador: _controller.nomeController,
              rotulo: 'Nome',
              dica: 'Digite seu nome',
            ),
            const SizedBox(height: 10),
            criarCaixaEdicao(
              controlador: _controller.emailController,
              rotulo: 'Email',
              dica: 'Digite seu email',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.confirmarLogin();
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
