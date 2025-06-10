import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';
import 'ar_view_page.dart';
import 'product_detail_page.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  // Dados simulados para o catálogo
  final List<Map<String, dynamic>> moveis = const [
    {
      'nome': 'Cadeira Moderna',
      'imagem': 'assets/images/cadeira.png',
      'modelo': 'assets/models/cadeira.glb',
      'preco': 'RS 299,90',
      'descricao': 'Cadeira ergonômica com design moderno e confortável. Ideal para escritórios e salas de jantar, proporciona conforto e estilo ao ambiente.',
      'especificacao': 'Material: Madeira e tecido\nAltura: 90cm\nLargura: 45cm\nProfundidade: 50cm',
    },
    {
      'nome': 'Sofá 3 Lugares',
      'imagem': 'assets/images/sofa.png',
      'modelo': 'assets/models/sofa.glb',
      'preco': 'RS 1.299,90',
      'descricao': 'Sofá espaçoso e confortável para até 3 pessoas. Revestimento em tecido premium, perfeito para salas de estar modernas.',
      'especificacao': 'Material: Madeira, espuma e tecido\nAltura: 85cm\nLargura: 200cm\nProfundidade: 90cm',
    },
    {
      'nome': 'Armário Moderno',
      'imagem': 'assets/images/armario.png',
      'modelo': 'assets/models/armario.glb',
      'preco': 'RS 1.100,00',
      'descricao': 'Armário com design contemporâneo, portas de correr e amplo espaço interno. Ideal para quartos e escritórios.',
      'especificacao': 'Material: MDF\nAltura: 180cm\nLargura: 120cm\nProfundidade: 50cm',
    },
    {
      'nome': 'Prateleira - Soft',
      'imagem': 'assets/images/prateleira.png',
      'modelo': 'assets/models/prateleira.glb',
      'preco': 'RS 350,00',
      'descricao': 'Prateleira minimalista, perfeita para organizar livros e objetos decorativos. Acabamento suave e resistente.',
      'especificacao': 'Material: Madeira\nAltura: 30cm\nLargura: 100cm\nProfundidade: 25cm',
    },
    {
      'nome': 'Poltrona - King',
      'imagem': 'assets/images/poltrona.png',
      'modelo': 'assets/models/poltrona.glb',
      'preco': 'RS 2.300,00',
      'descricao': 'Poltrona de luxo com design clássico, estofamento macio e apoio para braços. Ideal para leitura e relaxamento.',
      'especificacao': 'Material: Madeira, espuma e couro sintético\nAltura: 100cm\nLargura: 80cm\nProfundidade: 90cm',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Catálogo de Móveis',
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      body: Center(
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 28,
            mainAxisSpacing: 28,
          ),
          itemCount: moveis.length,
          itemBuilder: (context, index) {
            final movel = moveis[index];
            return _buildMovelCard(context, movel);
          },
        ),
      ),
    );
  }

  Widget _buildMovelCard(BuildContext context, Map<String, dynamic> movel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              image: movel['imagem'],
              title: movel['nome'],
              price: movel['preco'],
              description: movel['descricao'],
              especificacao: movel['especificacao'],
              modeloPath: movel['modelo'],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                movel['imagem'],
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              movel['nome'],
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColors.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              movel['preco'],
              style: GoogleFonts.poppins(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArViewPage(
                          modeloPath: movel['modelo'],
                          modelName: movel['nome'],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.view_in_ar, size: 18),
                  label: const Text('Ver em AR'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}