import 'package:test_app/core/constants/app_constants.dart';

class Validators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password must be less than ${AppConstants.maxPasswordLength} characters';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Invalid amount';
    }
    if (amount <= 0) {
      return 'Amount must be greater than 0';
    }
    return null;
  }

  static String? validateCategoryName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Category name is required';
    }
    if (value.length > AppConstants.maxCategoryNameLength) {
      return 'Category name must be less than ${AppConstants.maxCategoryNameLength} characters';
    }
    return null;
  }

  static String? validateNote(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length > AppConstants.maxTransactionNoteLength) {
      return 'Note must be less than ${AppConstants.maxTransactionNoteLength} characters';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}