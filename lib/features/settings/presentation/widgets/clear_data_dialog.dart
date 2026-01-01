import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

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
    return AlertDialog(
      backgroundColor: AppColors.surfaceDark,
      title: _buildTitle(),
      content: _buildContent(context),
      actions: _buildActions(context),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.title,
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMessage(),
        const SizedBox(height: AppDimensions.paddingLarge),
        _buildDateSelector(context),
      ],
    );
  }

  Widget _buildMessage() {
    return Text(
      widget.message,
      style: const TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [_buildCancelButton(context), _buildClearButton()];
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Cancel'),
    );
  }

  Widget _buildClearButton() {
    return TextButton(
      onPressed: _selectedDate != null ? _handleConfirm : null,
      child: const Text('Clear', style: TextStyle(color: AppColors.error)),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: _buildDateSelectorContainer(),
    );
  }

  Widget _buildDateSelectorContainer() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: _buildDateSelectorDecoration(),
      child: _buildDateSelectorContent(),
    );
  }

  BoxDecoration _buildDateSelectorDecoration() {
    return BoxDecoration(
      border: Border.all(color: AppColors.sectionHeaderText),
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
    );
  }

  Widget _buildDateSelectorContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildDateText(), _buildCalendarIcon()],
    );
  }

  Widget _buildDateText() {
    return Text(
      _selectedDate != null ? _formatDate(_selectedDate!) : 'Select a date',
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
