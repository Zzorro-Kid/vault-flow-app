import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const AppBottomNavigationBar({super.key, required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavigationItems(context),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.surfaceDark,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: AppDimensions.shadowBlurRadius,
          offset: const Offset(0, -2),
        ),
      ],
    );
  }

  List<Widget> _buildNavigationItems(BuildContext context) {
    return [
      _buildNavItem(
        context: context,
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        label: 'Home',
        index: 0,
        route: '/home',
      ),
      _buildNavItem(
        context: context,
        icon: Icons.add_circle_outline,
        selectedIcon: Icons.add_circle,
        label: 'Add',
        index: 1,
        route: '/add-transaction',
      ),
      _buildNavItem(
        context: context,
        icon: Icons.category_outlined,
        selectedIcon: Icons.category,
        label: 'Categories',
        index: 2,
        route: '/category-list',
      ),
      _buildNavItem(
        context: context,
        icon: Icons.bar_chart_outlined,
        selectedIcon: Icons.bar_chart,
        label: 'Stats',
        index: 3,
        route: '/reports',
      ),
      _buildNavItem(
        context: context,
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: 'Settings',
        index: 4,
        route: '/settings',
      ),
    ];
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
    required String route,
  }) {
    final isSelected = currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _handleNavItemTap(context, isSelected, route),
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: isSelected ? AppColors.primary : Colors.white60,
                size: 22.0,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  color: isSelected ? AppColors.primary : Colors.white60,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavItemTap(BuildContext context, bool isSelected, String route) {
    if (!isSelected) {
      // ........
    }
  }
}
