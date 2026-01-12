import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/l10n/app_localizations.dart';

class ClearDataDialog extends StatefulWidget {
  final String title;
  final String message;
  final Function(DateTime date) onConfirm;

  const ClearDataDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  State<ClearDataDialog> createState() => _ClearDataDialogState();
}

class _ClearDataDialogState extends State<ClearDataDialog> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      backgroundColor: AppColors.surfaceDark,
      title: _buildTitle(),
      content: _buildContent(context, l10n),
      actions: _buildActions(context, l10n),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.title,
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildContent(BuildContext context, AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMessage(),
        const SizedBox(height: AppDimensions.paddingLarge),
        _buildDateSelector(context, l10n),
      ],
    );
  }

  Widget _buildMessage() {
    return Text(
      widget.message,
      style: const TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildActions(BuildContext context, AppLocalizations l10n) {
    return [_buildCancelButton(context, l10n), _buildClearButton(l10n)];
  }

  Widget _buildCancelButton(BuildContext context, AppLocalizations l10n) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(l10n.cancel),
    );
  }

  Widget _buildClearButton(AppLocalizations l10n) {
    return TextButton(
      onPressed: _selectedDate != null ? _handleConfirm : null,
      child: Text(l10n.clear, style: const TextStyle(color: AppColors.error)),
    );
  }

  Widget _buildDateSelector(BuildContext context, AppLocalizations l10n) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: _buildDateSelectorContainer(l10n),
    );
  }

  Widget _buildDateSelectorContainer(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: _buildDateSelectorDecoration(),
      child: _buildDateSelectorContent(l10n),
    );
  }

  BoxDecoration _buildDateSelectorDecoration() {
    return BoxDecoration(
      border: Border.all(color: AppColors.sectionHeaderText),
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
    );
  }

  Widget _buildDateSelectorContent(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildDateText(l10n), _buildCalendarIcon()],
    );
  }

  Widget _buildDateText(AppLocalizations l10n) {
    return Text(
      _selectedDate != null ? _formatDate(_selectedDate!) : l10n.selectADate,
      style: TextStyle(
        color: _selectedDate != null
            ? AppColors.categoryTitleText
            : AppColors.sectionHeaderText,
      ),
    );
  }

  Widget _buildCalendarIcon() {
    return const Icon(
      Icons.calendar_today,
      color: AppColors.primary,
      size: AppDimensions.iconSmall,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await _showDatePickerDialog(context);
    _updateSelectedDate(picked);
  }

  Future<DateTime?> _showDatePickerDialog(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) => _buildDatePickerTheme(context, child),
    );
  }

  Widget _buildDatePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(colorScheme: _buildDatePickerColorScheme()),
      child: child!,
    );
  }

  ColorScheme _buildDatePickerColorScheme() {
    return const ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.surfaceDark,
    );
  }

  void _updateSelectedDate(DateTime? picked) {
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _handleConfirm() {
    if (_selectedDate != null) {
      widget.onConfirm(_selectedDate!);
    }
  }
}
