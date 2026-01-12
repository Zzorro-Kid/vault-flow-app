import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/l10n/app_localizations.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  static final _containerDecoration = BoxDecoration(
    color: AppColors.surfaceDark,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.2),
        blurRadius: AppDimensions.shadowBlurRadius,
        offset: const Offset(0, -2),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _containerDecoration,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.bottomNavPaddingHorizontal,
            vertical: AppDimensions.bottomNavPaddingVertical,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavigationItems(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavigationItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _buildNavItem(
        context: context,
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        label: l10n.navHome,
        index: 0,
        route: '/home',
      ),
      _buildNavItem(
        context: context,
        icon: Icons.add_circle_outline,
        selectedIcon: Icons.add_circle,
        label: l10n.navAdd,
        index: 1,
        route: '/add-transaction',
      ),
      _buildNavItem(
        context: context,
        icon: Icons.category_outlined,
        selectedIcon: Icons.category,
        label: l10n.navCategories,
        index: 2,
        route: '/category-list',
      ),
      _buildNavItem(
        context: context,
        icon: Icons.bar_chart_outlined,
        selectedIcon: Icons.bar_chart,
        label: l10n.navStats,
        index: 3,
        route: '/reports',
      ),
      _buildNavItem(
        context: context,
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: l10n.navSettings,
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
        onTap: () => _handleNavItemTap(context, isSelected, index, route),
        borderRadius: BorderRadius.circular(
          AppDimensions.bottomNavBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.bottomNavItemPaddingHorizontal,
            vertical: AppDimensions.bottomNavItemPaddingVertical,
          ),
          child: _buildNavItemContent(
            icon: icon,
            selectedIcon: selectedIcon,
            label: label,
            isSelected: isSelected,
          ),
        ),
      ),
    );
  }

  static const _iconTextSpacing = SizedBox(
    height: AppDimensions.bottomNavIconTextSpacing,
  );

  Widget _buildNavItemContent({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNavItemIcon(icon, selectedIcon, isSelected),
        _iconTextSpacing,
        _buildNavItemLabel(label, isSelected),
      ],
    );
  }

  Widget _buildNavItemIcon(
    IconData icon,
    IconData selectedIcon,
    bool isSelected,
  ) {
    return Icon(
      isSelected ? selectedIcon : icon,
      color: isSelected ? AppColors.primary : Colors.white60,
      size: AppDimensions.bottomNavIconSize,
    );
  }

  Widget _buildNavItemLabel(String label, bool isSelected) {
    return Text(
      label,
      style: TextStyle(
        fontSize: AppDimensions.bottomNavFontSize,
        color: isSelected ? AppColors.primary : Colors.white60,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        height: 1.0,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  void _handleNavItemTap(
    BuildContext context,
    bool isSelected,
    int index,
    String route,
  ) {
    if (!isSelected) {
      if (onTap != null) {
        onTap!(index);
      } else {
        Navigator.pushReplacementNamed(context, route);
      }
    }
  }
}
