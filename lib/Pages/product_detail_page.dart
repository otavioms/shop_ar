import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';
import 'ar_view_page.dart';

class ProductDetailPage extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String description;
  final String? especificacao;
  final String? modeloPath;

  const ProductDetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    this.especificacao,
    this.modeloPath,
  });

  String getEspecificacao() {
    if (especificacao != null && especificacao!.isNotEmpty) return especificacao!;
    // Exemplos padrões para cada item
    switch (title) {
      case 'Cadeira Moderna':
        return 'Material: Madeira e tecido\nAltura: 90cm\nLargura: 45cm\nProfundidade: 50cm\nPeso: 7kg';
      case 'Sofá 3 Lugares':
        return 'Material: Madeira, espuma e tecido\nAltura: 85cm\nLargura: 200cm\nProfundidade: 90cm\nPeso: 35kg';
      case 'Armário Moderno':
        return 'Material: MDF\nAltura: 180cm\nLargura: 120cm\nProfundidade: 50cm\nPeso: 60kg';
      case 'Prateleira - Soft':
        return 'Material: Madeira\nAltura: 30cm\nLargura: 100cm\nProfundidade: 25cm\nPeso: 4kg';
      case 'Poltrona - King':
        return 'Material: Madeira, espuma e couro sintético\nAltura: 100cm\nLargura: 80cm\nProfundidade: 90cm\nPeso: 25kg';
      default:
        return 'Especificação técnica não disponível.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.card,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Image.asset(
                  image,
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (modeloPath != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ArViewPage(
                                    modeloPath: modeloPath!,
                                    nomeMovel: title,
                                  ),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('AR'),
                                  content: Text('Modelo AR não disponível para este item.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Fechar'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.view_in_ar, color: Colors.white),
                          label: Text('Ver em AR', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(120, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        price,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 48,
                        child: Builder(
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Item adicionado ao carrinho!')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(120, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                            ),
                            child: const Text('Adicionar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.primary,
                      indicator: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tabs: [
                        Tab(child: Text('Descrição', style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                        Tab(child: Text('Especificação', style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            description,
                            style: GoogleFonts.poppins(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            getEspecificacao(),
                            style: GoogleFonts.poppins(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 