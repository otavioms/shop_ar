import 'package:flutter/material.dart';
import 'home_page.dart';
import 'catalog_page.dart';
import '../app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Lista das páginas que serão exibidas
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Inicializa as páginas passando a função de navegação para a HomePage
    _pages = [
      HomePage(onNavigateToCatalog: () => _navigateToPage(1)),
      const CatalogPage(),
    ];
  }

  void _onItemTapped(int index) {
    _navigateToPage(index);
  }

  void _navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_module),
            label: 'Catálogo',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}