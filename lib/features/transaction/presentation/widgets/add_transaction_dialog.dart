import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';
import 'package:test_app/features/category/presentation/cubit/category_cubit.dart';
import 'package:test_app/features/category/presentation/cubit/category_state.dart';
import 'package:uuid/uuid.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function(TransactionData) onAdd;

  const AddTransactionDialog({super.key, required this.onAdd});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  String _selectedType = 'expense';
  CategoryData? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surfaceDark,
      title: _buildDialogTitle(),
      content: _buildDialogContent(),
      actions: _buildDialogActions(),
    );
  }

  Widget _buildDialogTitle() {
    return const Text(
      'Add Transaction',
      style: TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildDialogContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDescriptionField(),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildAmountField(),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildTypeSelector(),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildCategorySelector(),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildDateSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      style: const TextStyle(color: AppColors.categoryTitleText),
      decoration: _buildDescriptionFieldDecoration(),
      validator: _validateDescription,
    );
  }

  InputDecoration _buildDescriptionFieldDecoration() {
    return InputDecoration(
      labelText: 'Description',
      labelStyle: const TextStyle(color: AppColors.sectionHeaderText),
      border: _buildBorder(),
      enabledBorder: _buildEnabledBorder(),
      focusedBorder: _buildFocusedBorder(),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
    );
  }

  OutlineInputBorder _buildEnabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      borderSide: const BorderSide(color: AppColors.sectionHeaderText),
    );
  }

  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      borderSide: const BorderSide(color: AppColors.primary),
    );
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      style: const TextStyle(color: AppColors.categoryTitleText),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: _buildAmountFieldDecoration(),
      validator: _validateAmount,
    );
  }

  InputDecoration _buildAmountFieldDecoration() {
    return InputDecoration(
      labelText: 'Amount',
      labelStyle: const TextStyle(color: AppColors.sectionHeaderText),
      border: _buildBorder(),
      enabledBorder: _buildEnabledBorder(),
      focusedBorder: _buildFocusedBorder(),
    );
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  Widget _buildTypeSelector() {
    return Row(
      children: [
        _buildTypeButton('Expense', 'expense'),
        const SizedBox(width: AppDimensions.paddingMedium),
        _buildTypeButton('Income', 'income'),
      ],
    );
  }

  Widget _buildTypeButton(String label, String type) {
    final isSelected = _selectedType == type;
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onTypeButtonPressed(type),
        style: _buildTypeButtonStyle(isSelected),
        child: Text(label),
      ),
    );
  }

  void _onTypeButtonPressed(String type) {
    setState(() {
      _selectedType = type;
      _selectedCategory = null;
    });
  }

  ButtonStyle _buildTypeButtonStyle(bool isSelected) {
    return ElevatedButton.styleFrom(
      backgroundColor: isSelected ? AppColors.primary : AppColors.surfaceDark,
      foregroundColor: isSelected ? Colors.white : AppColors.sectionHeaderText,
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.sectionHeaderText,
      ),
    );
  }

  Widget _buildCategorySelector() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categories = state is CategoryLoaded
            ? state.categories
                  .where((cat) => cat.type == _selectedType)
                  .toList()
            : <CategoryData>[];

        if (categories.isEmpty) {
          return _buildEmptyCategoriesText();
        }

        return DropdownButtonFormField<CategoryData>(
          initialValue: _selectedCategory,
          dropdownColor: AppColors.surfaceDark,
          style: const TextStyle(color: AppColors.categoryTitleText),
          decoration: _buildCategoryFieldDecoration(),
          items: _buildCategoryDropdownItems(categories),
          onChanged: _onCategoryChanged,
          validator: _validateCategory,
        );
      },
    );
  }

  Widget _buildEmptyCategoriesText() {
    return const Text(
      'No categories available',
      style: TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  InputDecoration _buildCategoryFieldDecoration() {
    return InputDecoration(
      labelText: 'Category',
      labelStyle: const TextStyle(color: AppColors.sectionHeaderText),
      border: _buildBorder(),
      enabledBorder: _buildEnabledBorder(),
      focusedBorder: _buildFocusedBorder(),
    );
  }

  List<DropdownMenuItem<CategoryData>> _buildCategoryDropdownItems(
    List<CategoryData> categories,
  ) {
    return categories.map((category) {
      return DropdownMenuItem<CategoryData>(
        value: category,
        child: Text(category.name),
      );
    }).toList();
  }

  void _onCategoryChanged(CategoryData? newValue) {
    setState(() {
      _selectedCategory = newValue;
    });
  }

  String? _validateCategory(CategoryData? value) {
    if (value == null) {
      return 'Please select a category';
    }
    return null;
  }

  Widget _buildDateSelector() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: _buildDateFieldDecoration(),
        child: _buildFormattedDateText(),
      ),
    );
  }

  InputDecoration _buildDateFieldDecoration() {
    return InputDecoration(
      labelText: 'Date',
      labelStyle: const TextStyle(color: AppColors.sectionHeaderText),
      border: _buildBorder(),
      enabledBorder: _buildEnabledBorder(),
    );
  }

  Widget _buildFormattedDateText() {
    return Text(
      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) => _buildDatePickerTheme(context, child),
    );
    _updateSelectedDate(picked);
  }

  Widget _buildDatePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          surface: AppColors.surfaceDark,
        ),
      ),
      child: child!,
    );
  }

  void _updateSelectedDate(DateTime? picked) {
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  List<Widget> _buildDialogActions() {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: _handleSubmit,
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
        child: const Text('Add'),
      ),
    ];
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final transaction = TransactionData(
        id: const Uuid().v4(),
        amount: double.parse(_amountController.text),
        category: _selectedCategory!,
        description: _descriptionController.text,
        date: _selectedDate,
        type: _selectedType,
      );
      widget.onAdd(transaction);
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
