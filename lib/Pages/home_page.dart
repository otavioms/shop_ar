import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onNavigateToCatalog;

  const HomePage({super.key, this.onNavigateToCatalog});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 64) / 2;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.accent, AppColors.background],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Escolha Seu Móvel',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Card principal do sofá (agora clicável)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(
                              image: 'assets/images/sofa.png',
                              title: 'Sofá 3 Lugares',
                              price: 'R\$ 1.299,90',
                              description: 'Sofá confortável para sua sala com tecido premium.',
                              modeloPath: 'assets/models/sofa.glb',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 24,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/sofa.png',
                                height: 100,
                              ),
                            ),
                            Positioned(
                              left: 20,
                              bottom: 20,
                              child: Text(
                                '30% Off',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Novidades',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildNovidadeCard(
                          context,
                          'assets/images/prateleira.png',
                          'Prateleira - Soft',
                          'R\$ 350,00',
                          'Prateleira minimalista e resistente.',
                          'assets/models/prateleira.glb',
                          cardWidth,
                        ),
                        _buildNovidadeCard(
                          context,
                          'assets/images/poltrona.png',
                          'Poltrona - King',
                          'R\$ 2.300,00',
                          'Poltrona de luxo para relaxamento.',
                          'assets/models/poltrona.glb',
                          cardWidth,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Nova seção de Categorias em Destaque
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categorias em Destaque',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Ver todas',
                            style: GoogleFonts.poppins(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategoryCard(
                            context,
                            'Sala de Estar',
                            'assets/images/sofa.png',
                            AppColors.primary.withOpacity(0.1),
                          ),
                          _buildCategoryCard(
                            context,
                            'Quarto',
                            'assets/images/armario.png',
                            AppColors.accent.withOpacity(0.1),
                          ),
                          _buildCategoryCard(
                            context,
                            'Escritório',
                            'assets/images/cadeira.png',
                            Colors.purple.withOpacity(0.1),
                          ),
                          _buildCategoryCard(
                            context,
                            'Decoração',
                            'assets/images/prateleira.png',
                            Colors.orange.withOpacity(0.1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Decorative element at the bottom
                    Center(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, 10 * _animation.value),
                            child: Container(
                              width: 200,
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary.withOpacity(0.5),
                                    AppColors.primary,
                                    AppColors.primary.withOpacity(0.5),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Deslize para ver mais',
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNovidadeCard(BuildContext context, String image, String title, String price, String description, String modeloPath, double width) {
    final shortTitle = title.split(' ')[0];
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              image: image,
              title: title,
              price: price,
              description: description,
              modeloPath: modeloPath,
            ),
          ),
        );
      },
      child: Container(
        width: width,
        height: 220,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(image, height: 100),
              const SizedBox(height: 16),
              Text(
                shortTitle,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: GoogleFonts.poppins(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String image, Color backgroundColor) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              image,
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String? _getModeloPathForNovidade(String title) {
    switch (title) {
      case 'Prateleira - Soft':
        return 'assets/models/prateleira.glb';
      case 'Poltrona - King':
        return 'assets/models/poltrona.glb';
      default:
        return null;
    }
  }
}