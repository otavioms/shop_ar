import 'package:flutter/material.dart';


class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controladorNome = TextEditingController();
  TextEditingController _controladorEmail = TextEditingController();

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
    _controladorNome.dispose();
    _controladorEmail.dispose();
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
              controlador: _controladorNome,
              rotulo: 'Nome',
              dica: 'Digite seu nome',
            ),
            SizedBox(height: 10),
            criarCaixaEdicao(
              controlador: _controladorEmail,
              rotulo: 'Email',
              dica: 'Digite seu email',
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        tooltip: 'Confirmar',
        child: const Icon(Icons.add),
      ),
    );
  }
}