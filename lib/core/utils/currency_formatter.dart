import 'package:test_app/core/constants/currencies.dart';

class CurrencyFormatter {
  static String format(double amount, String currencyCode) {
    final currency = Currency.fromCode(currencyCode);
    final amountStr = amount.toStringAsFixed(2);
    return '${currency.symbol}$amountStr';
  }

  static String formatWithoutSymbol(double amount) {
    return amount.toStringAsFixed(2);
  }

  static String formatCompact(double amount, String currencyCode) {
    final currency = Currency.fromCode(currencyCode);

    if (amount.abs() >= 1000000) {
      return '${currency.symbol}${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount.abs() >= 1000) {
      return '${currency.symbol}${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return format(amount, currencyCode);
    }
  }

  static double? parse(String amountStr) {
    try {
      return double.parse(amountStr.replaceAll(RegExp(r'[^\d.]'), ''));
    } catch (e) {
      return null;
    }
  }
}
