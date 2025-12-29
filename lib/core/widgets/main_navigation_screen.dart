import 'package:flutter/material.dart';
import 'package:test_app/core/widgets/bottom_navigation_bar.dart';
import 'package:test_app/features/category/presentation/pages/category_screen.dart';
import 'package:test_app/features/home/presentation/pages/home_sceen.dart';
import 'package:test_app/features/transaction/presentation/pages/transaction_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    HomeScreen(),
    TransactionScreen(),
    CategoryScreen(),
    Center(child: Text('Stats - Coming Soon')), // TODO: Stats screen
    Center(child: Text('Settings - Coming Soon')), // TODO: Settings screen
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}