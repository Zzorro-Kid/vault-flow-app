import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

class PeriodSelector extends StatelessWidget {
  final String currentPeriod;
  final Function(String) onPeriodChanged;

  const PeriodSelector({
    super.key,
    required this.currentPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),
      child: _buildPeriodButtons(),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      boxShadow: [_buildContainerBoxShadow()],
    );
  }

  BoxShadow _buildContainerBoxShadow() {
    return BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: AppDimensions.chartShadowBlurRadius,
      offset: const Offset(0, 2),
    );
  }

  Widget _buildPeriodButtons() {
    return Row(
      children: [
        _buildPeriodButton('Day', 'day'),
        _buildPeriodButton('Week', 'week'),
        _buildPeriodButton('Month', 'month'),
        _buildPeriodButton('Year', 'year'),
      ],
    );
  }

  Widget _buildPeriodButton(String label, String period) {
    final isSelected = currentPeriod == period;

    return Expanded(
      child: _buildButtonGestureDetector(label, period, isSelected),
    );
  }

  Widget _buildButtonGestureDetector(
    String label,
    String period,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => onPeriodChanged(period),
      child: _buildButtonContainer(label, isSelected),
    );
  }

  Widget _buildButtonContainer(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.periodButtonPaddingVertical,
      ),
      decoration: _buildButtonDecoration(isSelected),
      child: _buildButtonLabel(label, isSelected),
    );
  }

  BoxDecoration _buildButtonDecoration(bool isSelected) {
    return BoxDecoration(
      gradient: _buildButtonGradient(isSelected),
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
    );
  }

  LinearGradient? _buildButtonGradient(bool isSelected) {
    if (!isSelected) return null;

    return const LinearGradient(
      colors: [AppColors.primary, AppColors.primaryDark],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  Widget _buildButtonLabel(String label, bool isSelected) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: _buildButtonLabelStyle(isSelected),
    );
  }

  TextStyle _buildButtonLabelStyle(bool isSelected) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMedium,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      color: _buildButtonLabelColor(isSelected),
    );
  }

  Color _buildButtonLabelColor(bool isSelected) {
    return isSelected
        ? AppColors.periodButtonTextActive
        : AppColors.periodButtonTextInactive;
  }
}
