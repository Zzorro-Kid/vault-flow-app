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
        child: Padding(
          padding: _buildContentPadding(),
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

  EdgeInsets _buildContentPadding() {
    return const EdgeInsets.symmetric(
      horizontal: AppDimensions.paddingMedium,
      vertical: AppDimensions.paddingSmall,
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

    return InkWell(
      onTap: () => _handleNavItemTap(context, isSelected, route),
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      child: Container(
        padding: _buildNavItemPadding(),
        decoration: _buildNavItemDecoration(isSelected),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNavIcon(isSelected, icon, selectedIcon),
            const SizedBox(height: 4),
            _buildNavLabel(isSelected, label),
          ],
        ),
      ),
    );
  }

  void _handleNavItemTap(BuildContext context, bool isSelected, String route) {
    if (!isSelected) {
      // ........
    }
  }

  EdgeInsets _buildNavItemPadding() {
    return const EdgeInsets.symmetric(
      horizontal: AppDimensions.paddingMedium,
      vertical: AppDimensions.paddingSmall,
    );
  }

  BoxDecoration _buildNavItemDecoration(bool isSelected) {
    return BoxDecoration(
      color: isSelected
          ? AppColors.primary.withValues(alpha: 0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
    );
  }

  Widget _buildNavIcon(bool isSelected, IconData icon, IconData selectedIcon) {
    return Icon(
      isSelected ? selectedIcon : icon,
      color: isSelected ? AppColors.primary : Colors.white60,
      size: AppDimensions.iconMedium,
    );
  }

  Widget _buildNavLabel(bool isSelected, String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        color: isSelected ? AppColors.primary : Colors.white60,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
