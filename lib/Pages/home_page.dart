import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onNavigateToCatalog;

  const HomePage({super.key, this.onNavigateToCatalog});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop AR',
          style: GoogleFonts.poppins(
            color: AppColors.background,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Bem-vindo ao Shop AR',
                style: GoogleFonts.poppins(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Descubra como os móveis ficam em sua casa antes de comprar!',
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Como usar:',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.looks_one, color: AppColors.primary),
                        title: Text(
                          'Navegue pelo catálogo de móveis',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.looks_two, color: AppColors.primary),
                        title: Text(
                          'Selecione um móvel para visualizar em AR',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.looks_3, color: AppColors.primary),
                        title: Text(
                          'Posicione o móvel em sua casa usando a câmera',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.view_module),
                  label: Text(
                    'Ver Catálogo',
                    style: GoogleFonts.poppins(),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.background,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: widget.onNavigateToCatalog,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}