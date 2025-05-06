import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';
import '../Controllers/login_controller.dart';
import 'main_screen.dart'; // Importar a nova tela MainScreen em vez de HomePage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final LoginController _controller = LoginController();

  String titulo = 'Bem-vindo!';
  String actionButton = 'Login';
  String toggleButton = 'Ainda não tem conta? Cadastre-se agora.';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: GoogleFonts.poppins(
                    fontSize: 26.0,
                    color: AppColors.background,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: TextFormField(
                    cursorColor: AppColors.primary,
                    style: GoogleFonts.poppins(color: AppColors.primary),
                    controller: _controller.emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                      labelText: 'E-mail',
                      labelStyle: GoogleFonts.poppins(
                        color: AppColors.background,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o seu e-mail!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  child: TextFormField(
                    cursorColor: AppColors.primary,
                    style: GoogleFonts.poppins(color: AppColors.primary),
                    controller: _controller.senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                      labelStyle: GoogleFonts.poppins(
                        color: AppColors.background,
                      ),
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe sua senha!';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 8 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) { // Adicionar validação do formulário
                        if (_controller.confirmarLogin()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MainScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login inválido')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            actionButton,
                            style: GoogleFonts.poppins(
                              fontSize: 20.0,
                              color: AppColors.background,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    toggleButton,
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}