import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/category_constants.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';
import 'package:test_app/l10n/app_localizations.dart';

class EditCategoryDialog extends StatefulWidget {
  final CategoryData category;
  final Function(CategoryData) onSave;

  const EditCategoryDialog({
    super.key,
    required this.category,
    required this.onSave,
  });

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  late String _selectedIcon;
  late int _selectedColor;
  late String _selectedType;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category.name);
    _selectedIcon = widget.category.icon;
    _selectedColor = widget.category.color;
    _selectedType = widget.category.type;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      backgroundColor: AppColors.surfaceDark,
      title: _buildDialogTitle(l10n),
      content: _buildDialogContent(),
      actions: _buildDialogActions(context, l10n),
    );
  }

  Widget _buildDialogTitle(AppLocalizations l10n) {
    return Text(
      l10n.editCategory,
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildDialogContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildFormFields(),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildNameField(),
      const SizedBox(height: AppDimensions.paddingLarge),
      _buildTypeSelector(),
      const SizedBox(height: AppDimensions.paddingLarge),
      _buildIconSelector(),
      const SizedBox(height: AppDimensions.paddingLarge),
      _buildColorSelector(),
    ];
  }

  List<Widget> _buildDialogActions(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return [_buildCancelButton(context, l10n), _buildSaveButton(l10n)];
  }

  Widget _buildCancelButton(BuildContext context, AppLocalizations l10n) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(l10n.cancel),
    );
  }

  Widget _buildSaveButton(AppLocalizations l10n) {
    return ElevatedButton(
      onPressed: _handleSubmit,
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
      child: Text(l10n.save),
    );
  }

  Widget _buildNameField() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return TextFormField(
          controller: _nameController,
          style: const TextStyle(color: AppColors.dialogInputText),
          decoration: _buildNameFieldDecoration(l10n),
          validator: _validateCategoryName,
        );
      },
    );
  }

  InputDecoration _buildNameFieldDecoration(AppLocalizations l10n) {
    return InputDecoration(
      labelText: l10n.categoryName,
      labelStyle: const TextStyle(color: AppColors.sectionHeaderText),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.sectionHeaderText),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
    );
  }

  String? _validateCategoryName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterACategoryName;
    }
    return null;
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTypeSelectorLabel(),
        const SizedBox(height: AppDimensions.paddingSmall),
        _buildTypeButtons(),
      ],
    );
  }

  Widget _buildTypeSelectorLabel() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return Text(
          l10n.type,
          style: const TextStyle(
            color: AppColors.sectionHeaderText,
            fontSize: AppDimensions.fontSizeMedium,
          ),
        );
      },
    );
  }

  Widget _buildTypeButtons() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return Row(
          children: [
            _buildTypeButton(l10n.expense, 'expense', AppColors.expensesStart),
            const SizedBox(width: AppDimensions.paddingMedium),
            _buildTypeButton(l10n.income, 'income', AppColors.incomeStart),
          ],
        );
      },
    );
  }

  Widget _buildTypeButton(String label, String type, Color color) {
    final isSelected = _selectedType == type;
    return Expanded(
      child: OutlinedButton(
        onPressed: () => setState(() => _selectedType = type),
        style: _buildTypeButtonStyle(isSelected, color),
        child: _buildTypeButtonChild(label, isSelected, color),
      ),
    );
  }

  ButtonStyle _buildTypeButtonStyle(bool isSelected, Color color) {
    return OutlinedButton.styleFrom(
      backgroundColor: isSelected
          ? color.withValues(alpha: 0.2)
          : AppColors.buttonTransparent,
      side: BorderSide(color: isSelected ? color : AppColors.sectionHeaderText),
    );
  }

  Widget _buildTypeButtonChild(String label, bool isSelected, Color color) {
    return Text(
      label,
      style: TextStyle(color: isSelected ? color : AppColors.sectionHeaderText),
    );
  }

  Widget _buildIconSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconSelectorLabel(),
        const SizedBox(height: AppDimensions.paddingSmall),
        _buildIconGrid(),
      ],
    );
  }

  Widget _buildIconSelectorLabel() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return Text(
          l10n.icon,
          style: const TextStyle(
            color: AppColors.sectionHeaderText,
            fontSize: AppDimensions.fontSizeMedium,
          ),
        );
      },
    );
  }

  Widget _buildIconGrid() {
    return Wrap(
      spacing: AppDimensions.paddingSmall,
      runSpacing: AppDimensions.paddingSmall,
      children: CategoryConstants.availableIcons.map((iconData) {
        return _buildIconItem(iconData);
      }).toList(),
    );
  }

  Widget _buildIconItem(Map<String, dynamic> iconData) {
    final isSelected = _selectedIcon == iconData['name'];
    return InkWell(
      onTap: () => setState(() => _selectedIcon = iconData['name']),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingSmall),
        decoration: _buildIconItemDecoration(isSelected),
        child: _buildIconItemIcon(iconData, isSelected),
      ),
    );
  }

  BoxDecoration _buildIconItemDecoration(bool isSelected) {
    return BoxDecoration(
      color: isSelected
          ? AppColors.primary.withValues(alpha: 0.2)
          : AppColors.surfaceDark,
      border: Border.all(
        color: isSelected ? AppColors.primary : AppColors.categoryBorder,
      ),
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
    );
  }

  Widget _buildIconItemIcon(Map<String, dynamic> iconData, bool isSelected) {
    return Icon(
      iconData['icon'],
      color: isSelected ? AppColors.primary : AppColors.sectionHeaderText,
      size: AppDimensions.iconMedium,
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColorSelectorLabel(),
        const SizedBox(height: AppDimensions.paddingSmall),
        _buildColorGrid(),
      ],
    );
  }

  Widget _buildColorSelectorLabel() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return Text(
          l10n.color,
          style: const TextStyle(
            color: AppColors.sectionHeaderText,
            fontSize: AppDimensions.fontSizeMedium,
          ),
        );
      },
    );
  }

  Widget _buildColorGrid() {
    return Wrap(
      spacing: AppDimensions.paddingSmall,
      runSpacing: AppDimensions.paddingSmall,
      children: CategoryConstants.availableColors.map((color) {
        return _buildColorItem(color);
      }).toList(),
    );
  }

  Widget _buildColorItem(int color) {
    final isSelected = _selectedColor == color;
    return InkWell(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        width: AppDimensions.colorPickerSize,
        height: AppDimensions.colorPickerSize,
        decoration: _buildColorItemDecoration(color, isSelected),
      ),
    );
  }

  BoxDecoration _buildColorItemDecoration(int color, bool isSelected) {
    return BoxDecoration(
      color: Color(color),
      shape: BoxShape.circle,
      border: Border.all(
        color: isSelected
            ? AppColors.dialogInputBorder
            : AppColors.buttonTransparent,
        width: AppDimensions.borderWidthMedium,
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final updatedCategory = CategoryData(
        id: widget.category.id,
        name: _nameController.text.trim(),
        icon: _selectedIcon,
        color: _selectedColor,
        type: _selectedType,
      );
      widget.onSave(updatedCategory);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
