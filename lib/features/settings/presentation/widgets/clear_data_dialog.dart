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
      title: Text(
        widget.title,
        style: const TextStyle(color: AppColors.categoryTitleText),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.message,
            style: const TextStyle(color: AppColors.sectionHeaderText),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildDateSelector(context),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _selectedDate != null ? _handleConfirm : null,
          child: const Text('Clear', style: TextStyle(color: AppColors.error)),
        ),
      ],
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.sectionHeaderText),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate != null
                  ? _formatDate(_selectedDate!)
                  : 'Select a date',
              style: TextStyle(
                color: _selectedDate != null
                    ? AppColors.categoryTitleText
                    : AppColors.sectionHeaderText,
              ),
            ),
            const Icon(
              Icons.calendar_today,
              color: AppColors.primary,
              size: AppDimensions.iconSmall,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              surface: AppColors.surfaceDark,
            ),
          ),
          child: child!,
        );
      },
    );

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
