import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';
import '../Controllers/login_controller.dart';
import 'home_page.dart';

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
      backgroundColor: AppColors.accent, // Cor de fundo (não é roxo)
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
                    color: AppColors.background, // Cor de texto
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
                          color:
                              AppColors
                                  .primary, // Cor desejada para o estado padrão
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ), // Cor primária
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ), // Cor primária
                      ),
                      labelText: 'E-mail',
                      labelStyle: GoogleFonts.poppins(
                        color: AppColors.background, // Cor de texto
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
                          color:
                              AppColors
                                  .primary, // Cor desejada para o estado padrão
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ), // Cor primária
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ), // Cor primária
                      ),
                      labelStyle: GoogleFonts.poppins(
                        color: AppColors.background, // Cor de texto
                      ),
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe sua senha!';
                      } else if (value.length < 8) {
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
                      if (_controller.confirmarLogin()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login inválido')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, // Cor primária
                      foregroundColor: AppColors.background, // Define a cor dos ícones e textos
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
                              color: AppColors.background, // Cor de texto
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
                    ), // Cor primária
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
