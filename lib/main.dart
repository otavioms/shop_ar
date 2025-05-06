import 'package:flutter/material.dart';
import 'package:shop_ar/Pages/home_page.dart';
import 'Pages/catalog_page.dart';
import 'Pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const LoginPage());
  }
}
