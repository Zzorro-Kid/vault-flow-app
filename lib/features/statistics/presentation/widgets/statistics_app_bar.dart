import 'package:flutter/material.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';

class StatisticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatisticsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      title: Text(
        'Statistics',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
