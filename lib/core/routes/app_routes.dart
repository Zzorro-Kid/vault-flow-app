import 'package:flutter/material.dart';
import 'package:test_app/core/widgets/main_navigation_screen.dart';
import 'package:test_app/features/auth/presentation/pages/auth_screen.dart';

class AppRouter {
  static const String auth = '/auth';
  static const String home = '/home';
  static const String addTransaction = '/add-transaction';
  static const String editTransaction = '/edit-transaction';
  static const String transactionList = '/transaction-list';
  static const String categoryList = '/category-list';
  static const String addCategory = '/add-category';
  static const String editCategory = '/edit-category';
  static const String reports = '/reports';
  static const String settings = '/settings';

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return _createFadeRoute(const AuthScreen());

      case home:
        return _createFadeRoute(const MainNavigationScreen(initialIndex: 0));

      case categoryList:
        return _createFadeRoute(const MainNavigationScreen(initialIndex: 2));

      case addTransaction:
        return _createFadeRoute(const MainNavigationScreen(initialIndex: 1));

      // case stats:
      //   return MaterialPageRoute(builder: (_) => const StatsScreen());

      // case settings:
      //   return MaterialPageRoute(builder: (_) => const SettingsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }

  PageRouteBuilder<dynamic> _createFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 90),
      reverseTransitionDuration: const Duration(milliseconds: 90),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
