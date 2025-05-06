import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';
import 'ar_view_page.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  // Dados simulados para o catálogo
  final List<Map<String, dynamic>> moveis = const [
    {
      'nome': 'Cadeira Moderna',
      'imagem': 'assets/images/cadeira.png',
      'modelo': 'assets/models/cadeira.glb',
      'preco': 'RS 299,90',
      'descricao': 'Cadeira ergonômica com design moderno e confortável.',
    },
    {
      'nome': 'Sofá 3 Lugares',
      'imagem': 'assets/images/sofa.png',
      'modelo': 'assets/models/sofa.glb',
      'preco': 'RS 1.299,90',
      'descricao': 'Sofá confortável para sua sala com tecido premium.',
    },
    {
      'nome': 'Mesa de Jantar',
      'imagem': 'assets/images/mesa.png',
      'modelo': 'assets/models/mesa.glb',
      'preco': 'RS 899,90',
      'descricao': 'Mesa de jantar para 6 pessoas, feita em madeira maciça.',
    },
    {
      'nome': 'Estante Modular',
      'imagem': 'assets/images/estante.png',
      'modelo': 'assets/models/estante.glb',
      'preco': 'RS 599,90',
      'descricao': 'Estante versátil para livros e decoração.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catálogo de Móveis',
          style: GoogleFonts.poppins(
            color: AppColors.background,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 2,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: moveis.length,
        itemBuilder: (context, index) {
          final movel = moveis[index];
          return _buildMovelCard(context, movel);
        },
      ),
    );
  }

  Widget _buildMovelCard(BuildContext context, Map<String, dynamic> movel) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem do móvel (com placeholder)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              width: double.infinity,
              child: Icon(
                Icons.chair,
                size: 80,
                color: AppColors.primary,
              ),
              // Em produção você usaria:
              // Image.asset(
              //   movel['imagem']!,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movel['nome'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movel['preco'],
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArViewPage(
                          modeloPath: movel['modelo'],
                          nomeMovel: movel['nome'],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.view_in_ar, size: 16),
                  label: const Text('Ver em AR'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.background,
                    minimumSize: const Size(double.infinity, 30),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: GoogleFonts.poppins(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}