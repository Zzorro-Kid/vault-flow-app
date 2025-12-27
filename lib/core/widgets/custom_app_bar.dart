import 'package:flutter/material.dart';
import 'package:test_app/core/themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double height;
  final bool centerTitle;
  final double topPadding;

  const CustomAppBar({
    super.key,
    required this.title,
    this.height = kToolbarHeight,
    this.centerTitle = true,
    this.topPadding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: centerTitle,
          flexibleSpace: _buildAppBarBackground(),
          title: title,
        ),
      ),
    );
  }

  Widget _buildAppBarBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.appBarGradientEdge,
            AppColors.appBarGradientCenter,
            AppColors.appBarGradientEdge,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
