import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'ar_view_page.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  final List<Map<String, String>> moveis = const [
    {
      'nome': 'Cadeira',
      'imagem': 'assets/images/cadeira.png',
      'modelo': 'assets/models/cadeira.glb',
    },
    {
      'nome': 'Sofa',
      'imagem': 'assets/images/sofa.png',
      'modelo': 'assets/models/sofa.glb',
    },
    // Adicione mais itens conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Móveis'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
      ),
      body: ListView.builder(
        itemCount: moveis.length,
        itemBuilder: (context, index) {
          final movel = moveis[index];
          return Card(
            margin: const EdgeInsets.all(12.0),
            child: ListTile(
              leading: Image.asset(movel['imagem']!),
              title: Text(movel['nome']!),
              trailing: IconButton(
                icon: const Icon(Icons.view_in_ar),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ArViewPage(
                        modeloPath: movel['modelo']!,
                        nomeMovel: movel['nome']!,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
