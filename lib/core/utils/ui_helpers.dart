import 'package:flutter/material.dart';
import 'package:test_app/core/themes/app_colors.dart';

class UiHelpers {
  UiHelpers._();

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  static Color getOperationSnackBarColor(String message) {
    final operationType = _getOperationType(message);

    return switch (operationType) {
      'deleted' => AppColors.error,
      'updated' => AppColors.primary,
      'added' => AppColors.incomeStart,
      _ => AppColors.incomeStart,
    };
  }

  static String _getOperationType(String message) {
    final lowerMessage = message.toLowerCase();
    if (lowerMessage.contains('deleted')) return 'deleted';
    if (lowerMessage.contains('updated')) return 'updated';
    return 'added';
  }
}
