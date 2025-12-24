import 'package:flutter/material.dart';
import 'package:test_app/features/auth/presentation/pages/auth_screen.dart';
import 'package:test_app/features/home/presentation/pages/home_sceen.dart';
// import 'package:test_app/features/transaction/presentation/pages/add_transaction_screen.dart';
// import 'package:test_app/features/transaction/presentation/pages/transaction_list_screen.dart';
// import 'package:test_app/features/category/presentation/pages/category_list_screen.dart';
// import 'package:test_app/features/category/presentation/pages/add_category_screen.dart';
// import 'package:test_app/features/reports/presentation/pages/reports_screen.dart';
// import 'package:test_app/features/settings/presentation/pages/settings_screen.dart';

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
        return _createFadeRoute(const HomeScreen());

      // case addTransaction:
      //   return MaterialPageRoute(builder: (_) => const AddTransactionScreen());

      // case editTransaction:
      //   final args = settings.arguments as Map<String, dynamic>?;
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         AddTransactionScreen(transactionId: args?['transactionId']),
      //   );

      // case transactionList:
      //   return MaterialPageRoute(builder: (_) => const TransactionListScreen());

      // case categoryList:
      //   return MaterialPageRoute(builder: (_) => const CategoryListScreen());

      // case addCategory:
      //   return MaterialPageRoute(builder: (_) => const AddCategoryScreen());

      // case editCategory:
      //   final args = settings.arguments as Map<String, dynamic>?;
      //   return MaterialPageRoute(
      //     builder: (_) => AddCategoryScreen(categoryId: args?['categoryId']),
      //   );

      // case reports:
      //   return MaterialPageRoute(builder: (_) => const ReportsScreen());

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
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
