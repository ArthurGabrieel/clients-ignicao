import 'package:flutter/material.dart';

import 'manage.dart';
import 'search.dart';
import 'update.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return const ManagePage();
      case 1:
        return SearchPage();
      case 2:
        return const UpdatePage();
      default:
        return const ManagePage();
    }
  }

  static const List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.manage_accounts),
      label: 'Gerenciar',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_search),
      label: 'Buscar',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Atualizar senha',
    ),
  ];

  Widget _buildPageTransition(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-2, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: _buildPageTransition,
        child: _getSelectedPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.colorScheme.background,
        fixedColor: theme.colorScheme.tertiary,
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
