import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      height: AppDimensions.appBarHeightOther,
      topPadding: AppDimensions.appBarTopPadding,
      title: Transform.translate(
        offset: const Offset(0, AppDimensions.appBarTitleOffsetY),
        child: const Text(
          'Categories',
          style: TextStyle(
            fontSize: AppDimensions.fontSizeXXLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.categoryTitleText,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        AppDimensions.appBarHeightOther + AppDimensions.appBarTopPadding,
      );
}