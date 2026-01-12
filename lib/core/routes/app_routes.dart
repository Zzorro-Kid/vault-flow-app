import 'package:flutter/material.dart';
import 'package:test_app/features/auth/presentation/pages/auth_screen.dart';
import 'package:test_app/features/category/presentation/pages/category_screen.dart';
import 'package:test_app/features/home/presentation/pages/home_sceen.dart';
import 'package:test_app/features/settings/presentation/pages/settings_screen.dart';
import 'package:test_app/features/statistics/presentation/pages/statistics_screen.dart';
import 'package:test_app/features/transaction/presentation/pages/transaction_screen.dart';
import 'package:test_app/l10n/app_localizations.dart';

class AppRouter {
  static const String auth = '/auth';
  static const String home = '/home';
  static const String addTransaction = '/add-transaction';
  static const String categoryList = '/category-list';
  static const String reports = '/reports';
  static const String settings = '/settings';

  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case auth:
        return _createFadeRoute(const AuthScreen());

      case home:
        return _createFadeRoute(const HomeScreen());

      case addTransaction:
        return _createFadeRoute(const TransactionScreen());

      case categoryList:
        return _createFadeRoute(const CategoryScreen());

      case reports:
        return _createFadeRoute(const StatisticsScreen());

      case settings:
        return _createFadeRoute(const SettingsScreen());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(AppLocalizations.of(context)!.noRouteDefined),
            ),
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
