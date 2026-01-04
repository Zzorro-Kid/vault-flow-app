class AppConstants {
  // App Info
  static const String appName = 'VaultFlow';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyHasPassword = 'has_password';
  static const String keyUseBiometric = 'use_biometric';
  static const String keySelectedCurrency = 'selected_currency';
  static const String keyThemeMode = 'theme_mode';
  static const String keyEncryptionKey = 'encryption_key';
  static const String keyPasswordHash = 'password_hash';
  static const String keyTransactions = 'transactions_data';
  static const String keyCategories = 'categories_data';
  static const String keyUserSettings = 'user_settings';

  // Encryption
  static const String aesEncryptionKey = 'aes_encryption_key';

  // Date Formats
  static const String dateFormat = 'dd.MM.yyyy';
  static const String dateTimeFormat = 'dd.MM.yyyy HH:mm';

  // Limits
  static const int maxCategoryNameLength = 50;
  static const int maxTransactionNoteLength = 200;
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;

  // Default Values
  static const String defaultCurrency = 'USD';
}
