import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isDestructive;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: _buildPaddedContent());
  }

  Widget _buildPaddedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingMedium,
      ),
      child: _buildTileContent(),
    );
  }

  Widget _buildTileContent() {
    return Row(
      children: [
        _buildIcon(),
        const SizedBox(width: AppDimensions.paddingMedium),
        _buildContent(),
        _buildTrailing(),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      decoration: _buildIconDecoration(),
      child: Icon(
        icon,
        color: isDestructive ? AppColors.error : AppColors.primary,
        size: AppDimensions.iconMedium,
      ),
    );
  }

  BoxDecoration _buildIconDecoration() {
    return BoxDecoration(
      color: _getIconBackgroundColor(),
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
    );
  }

  Color _getIconBackgroundColor() {
    return isDestructive
        ? AppColors.error.withValues(alpha: 0.1)
        : AppColors.primary.withValues(alpha: 0.1);
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildTitle(), const SizedBox(height: 4), _buildSubtitle()],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: isDestructive ? AppColors.error : AppColors.categoryTitleText,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        color: AppColors.sectionHeaderText,
      ),
    );
  }

  Widget _buildTrailing() {
    if (trailing != null) {
      return trailing!;
    }

    if (onTap != null) {
      return const Icon(
        Icons.chevron_right,
        color: AppColors.sectionHeaderText,
      );
    }

    return const SizedBox.shrink();
  }
}
