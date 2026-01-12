import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';
import 'package:test_app/features/category/presentation/cubit/category_cubit.dart';
import 'package:test_app/features/category/presentation/cubit/category_state.dart';
import 'package:uuid/uuid.dart';
import 'package:test_app/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      backgroundColor: AppColors.surfaceDark,
      title: _buildDialogTitle(l10n),
      content: _buildDialogContent(l10n),
      actions: _buildDialogActions(l10n),
    );
  }

  Widget _buildDialogTitle(AppLocalizations l10n) {
    return Text(
      l10n.addTransaction,
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildDialogContent(AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDescriptionField(l10n),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildAmountField(l10n),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildTypeSelector(l10n),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildCategorySelector(l10n),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildDateSelector(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionField(AppLocalizations l10n) {
    return TextFormField(
      controller: _descriptionController,
      style: const TextStyle(color: AppColors.categoryTitleText),
      decoration: _buildDescriptionFieldDecoration(l10n),
      validator: (value) => _validateDescription(value, l10n),
    );
  }

  InputDecoration _buildDescriptionFieldDecoration(AppLocalizations l10n) {
    return InputDecoration(
      labelText: l10n.description,
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

  String? _validateDescription(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterADescription;
    }
    return null;
  }

  Widget _buildAmountField(AppLocalizations l10n) {
    return TextFormField(
      controller: _amountController,
      style: const TextStyle(color: AppColors.categoryTitleText),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: _buildAmountFieldDecoration(l10n),
      validator: (value) => _validateAmount(value, l10n),
    );
  }

  InputDecoration _buildAmountFieldDecoration(AppLocalizations l10n) {
    return InputDecoration(
      labelText: l10n.amount,
      labelStyle: const TextStyle(color: AppColors.sectionHeaderText),
      border: _buildBorder(),
      enabledBorder: _buildEnabledBorder(),
      focusedBorder: _buildFocusedBorder(),
    );
  }

  String? _validateAmount(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterAnAmount;
    }
    if (double.tryParse(value) == null) {
      return l10n.pleaseEnterAValidNumber;
    }
    return null;
  }

  Widget _buildTypeSelector(AppLocalizations l10n) {
    return Row(
      children: [
        _buildTypeButton(l10n.expense, 'expense'),
        const SizedBox(width: AppDimensions.paddingMedium),
        _buildTypeButton(l10n.income, 'income'),
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

  Widget _buildCategorySelector(AppLocalizations l10n) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categories = state is CategoryLoaded
            ? state.categories
                  .where((cat) => cat.type == _selectedType)
                  .toList()
            : <CategoryData>[];

        if (categories.isEmpty) {
          return _buildEmptyCategoriesText(l10n);
        }

        return DropdownButtonFormField<CategoryData>(
          initialValue: _selectedCategory,
          dropdownColor: AppColors.surfaceDark,
          style: const TextStyle(color: AppColors.categoryTitleText),
          decoration: _buildCategoryFieldDecoration(l10n),
          items: _buildCategoryDropdownItems(categories),
          onChanged: _onCategoryChanged,
          validator: (value) => _validateCategory(value, l10n),
        );
      },
    );
  }

  Widget _buildEmptyCategoriesText(AppLocalizations l10n) {
    return Text(
      l10n.noCategoriesAvailable,
      style: const TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  InputDecoration _buildCategoryFieldDecoration(AppLocalizations l10n) {
    return InputDecoration(
      labelText: l10n.category,
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

  String? _validateCategory(CategoryData? value, AppLocalizations l10n) {
    if (value == null) {
      return l10n.pleaseSelectACategory;
    }
    return null;
  }

  Widget _buildDateSelector(AppLocalizations l10n) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: _buildDateFieldDecoration(l10n),
        child: _buildFormattedDateText(),
      ),
    );
  }

  InputDecoration _buildDateFieldDecoration(AppLocalizations l10n) {
    return InputDecoration(
      labelText: l10n.date,
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

  List<Widget> _buildDialogActions(AppLocalizations l10n) {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(l10n.cancel),
      ),
      ElevatedButton(
        onPressed: _handleSubmit,
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
        child: Text(l10n.add),
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
