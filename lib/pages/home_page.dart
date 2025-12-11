// lib/main.dart
import 'package:calculadoraimc/pages/calculadora_page.dart';
import 'package:calculadoraimc/pages/configuracoes_page.dart';
import 'package:calculadoraimc/pages/historico_page.dart';
import 'package:flutter/material.dart';


class RootPage extends StatefulWidget {
  const RootPage({super.key});
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final PageController _pageController = PageController(initialPage: 1);
  int _index = 1; // começo na calculadora

  void _onNavTap(int i) {
    setState(() => _index = i);
    _pageController.animateToPage(i,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (i) => setState(() => _index = i),
        children: const [
          HistoryPage(),
          CalculatorPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Histórico'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calcular'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
        ],
      ),
    );
  }
}
