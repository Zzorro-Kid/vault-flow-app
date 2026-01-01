import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/category_constants.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/utils/id_generator.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';

class AddCategoryDialog extends StatefulWidget {
  final Function(CategoryData) onAdd;

  const AddCategoryDialog({super.key, required this.onAdd});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String _selectedIcon = 'category';
  int _selectedColor = 0xFF4CAF50;
  String _selectedType = 'expense';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surfaceDark,
      title: _buildDialogTitle(),
      content: _buildDialogContent(),
      actions: _buildDialogActions(context),
    );
  }

  Widget _buildDialogTitle() {
    return const Text(
      'Add Category',
      style: TextStyle(color: AppColors.categoryTitleText),
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

  List<Widget> _buildDialogActions(BuildContext context) {
    return [_buildCancelButton(context), _buildAddButton()];
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Cancel'),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: _handleSubmit,
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
      child: const Text('Add'),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      style: const TextStyle(color: AppColors.dialogInputText),
      decoration: _buildNameFieldDecoration(),
      validator: _validateCategoryName,
    );
  }

  InputDecoration _buildNameFieldDecoration() {
    return const InputDecoration(
      labelText: 'Category Name',
      labelStyle: TextStyle(color: AppColors.sectionHeaderText),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.sectionHeaderText),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
    );
  }

  String? _validateCategoryName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a category name';
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
    return const Text(
      'Type',
      style: TextStyle(
        color: AppColors.sectionHeaderText,
        fontSize: AppDimensions.fontSizeMedium,
      ),
    );
  }

  Widget _buildTypeButtons() {
    return Row(
      children: [
        _buildTypeButton('Expense', 'expense', AppColors.expensesStart),
        const SizedBox(width: AppDimensions.paddingMedium),
        _buildTypeButton('Income', 'income', AppColors.incomeStart),
      ],
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
    return const Text(
      'Icon',
      style: TextStyle(
        color: AppColors.sectionHeaderText,
        fontSize: AppDimensions.fontSizeMedium,
      ),
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
    return const Text(
      'Color',
      style: TextStyle(
        color: AppColors.sectionHeaderText,
        fontSize: AppDimensions.fontSizeMedium,
      ),
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
      final category = CategoryData(
        id: IdGenerator.generate(),
        name: _nameController.text.trim(),
        icon: _selectedIcon,
        color: _selectedColor,
        type: _selectedType,
      );
      widget.onAdd(category);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
