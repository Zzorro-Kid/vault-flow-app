import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      height: AppDimensions.appBarHeightHome,
      topPadding: AppDimensions.appBarTopPadding,
      title: Transform.translate(
        offset: const Offset(0, AppDimensions.appBarTitleOffsetY),
        child: _buildAppBarContent(),
      ),
    );
  }

  Widget _buildAppBarContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAppBarIcon(),
        const SizedBox(width: AppDimensions.radiusMedium),
        _buildAppBarTitle(),
      ],
    );
  }

  Widget _buildAppBarIcon() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(
          AppDimensions.appBarIconContainerRadius,
        ),
      ),
      child: const Icon(
        Icons.shield_outlined,
        color: Colors.white,
        size: AppDimensions.iconMedium,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'VaultFlow',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeXXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.categoryTitleText,
        letterSpacing: 0.5,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        AppDimensions.appBarHeightHome + AppDimensions.appBarTopPadding,
      );
}