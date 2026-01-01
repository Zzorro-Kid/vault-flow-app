import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(),
        const SizedBox(height: AppDimensions.paddingSmall),
        _buildSectionContent(),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: AppDimensions.fontSizeLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.sectionHeaderText,
        ),
      ),
    );
  }

  Widget _buildSectionContent() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Column(children: _buildChildrenWithDividers()),
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    final List<Widget> widgets = [];

    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);

      if (i < children.length - 1) {
        widgets.add(_buildDivider());
      }
    }

    return widgets;
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.sectionHeaderText,
      indent: AppDimensions.paddingLarge + AppDimensions.iconMedium,
    );
  }
}
