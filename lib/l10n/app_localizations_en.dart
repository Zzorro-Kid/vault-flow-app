// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'VaultFlow';

  @override
  String get navHome => 'Home';

  @override
  String get navAdd => 'Add';

  @override
  String get navCategories => 'Categories';

  @override
  String get navStats => 'Stats';

  @override
  String get navSettings => 'Settings';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get transactions => 'Transactions';

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get statistics => 'Statistics';

  @override
  String get settings => 'Settings';

  @override
  String get noRouteDefined => 'No route defined for this path';

  @override
  String get loading => 'Loading...';

  @override
  String get loadingSettings => 'Loading settings...';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get add => 'Add';

  @override
  String get save => 'Save';

  @override
  String get change => 'Change';

  @override
  String get clear => 'Clear';

  @override
  String get logout => 'Logout';

  @override
  String get unlock => 'Unlock';

  @override
  String get createPassword => 'Create Password';

  @override
  String get yesReset => 'Yes, Reset';

  @override
  String get expense => 'Expense';

  @override
  String get expense_plural => 'Expenses';

  @override
  String get income => 'Income';

  @override
  String get income_plural => 'Incomes';

  @override
  String get netBalance => 'Net Balance';

  @override
  String get balance => 'Balance';

  @override
  String get totalIncome => 'Total Income';

  @override
  String get totalExpenses => 'Total Expenses';

  @override
  String summaryFor(String period) {
    return 'Summary for $period';
  }

  @override
  String get periodDay => 'Day';

  @override
  String get periodWeek => 'Week';

  @override
  String get periodMonth => 'Month';

  @override
  String get periodYear => 'Year';

  @override
  String get expenseCategories => 'Expense Categories';

  @override
  String get incomeCategories => 'Income Categories';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String transactionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
      zero: 'No transactions',
    );
    return '$_temp0';
  }

  @override
  String get categoryBreakdown => 'Category Breakdown';

  @override
  String get dailyTrends => 'Daily Trends';

  @override
  String get noCategoryDataAvailable => 'No category data available';

  @override
  String get noTrendDataAvailable => 'No trend data available';

  @override
  String get noCategoriesYet => 'No categories yet';

  @override
  String get noTransactionsYet => 'No transactions yet';

  @override
  String get noCategoriesAvailable => 'No categories available';

  @override
  String get selectADate => 'Select a date';

  @override
  String get welcomeToVaultFlow => 'Welcome to VaultFlow';

  @override
  String get enterYourMasterPassword => 'Enter your master password';

  @override
  String get createMasterPassword => 'Create Master Password';

  @override
  String get passwordWillEncryptData =>
      'This password will encrypt all your data';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordMustBeAtLeast6Characters =>
      'Password must be at least 6 characters';

  @override
  String get pleaseEnterYourCurrentPassword =>
      'Please enter your current password';

  @override
  String get pleaseEnterANewPassword => 'Please enter a new password';

  @override
  String get pleaseConfirmYourNewPassword => 'Please confirm your new password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordWarning =>
      'This will delete ALL your data including transactions and categories. You will need to create a new password.\n\nAre you sure you want to continue?';

  @override
  String get addTransaction => 'Add Transaction';

  @override
  String get editTransaction => 'Edit Transaction';

  @override
  String get deleteTransaction => 'Delete Transaction';

  @override
  String confirmDeleteTransaction(String transactionTitle) {
    return 'Are you sure you want to delete \"$transactionTitle\"?';
  }

  @override
  String get description => 'Description';

  @override
  String get amount => 'Amount';

  @override
  String get category => 'Category';

  @override
  String get date => 'Date';

  @override
  String get type => 'Type';

  @override
  String get icon => 'Icon';

  @override
  String get color => 'Color';

  @override
  String get categoryName => 'Category Name';

  @override
  String get pleaseEnterADescription => 'Please enter a description';

  @override
  String get pleaseEnterAnAmount => 'Please enter an amount';

  @override
  String get pleaseEnterAValidNumber => 'Please enter a valid number';

  @override
  String get pleaseSelectACategory => 'Please select a category';

  @override
  String get pleaseEnterACategoryName => 'Please enter a category name';

  @override
  String get addCategory => 'Add Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get deleteCategory => 'Delete Category';

  @override
  String confirmDeleteCategory(String categoryName) {
    return 'Are you sure you want to delete \"$categoryName\"?';
  }

  @override
  String get security => 'Security';

  @override
  String get changePassword => 'Change Password';

  @override
  String get updateYourSecurityPassword => 'Update your security password';

  @override
  String get dataManagement => 'Data Management';

  @override
  String get exportToCSV => 'Export to CSV';

  @override
  String get exportYourTransactionsToCSVFile =>
      'Export your transactions to CSV file';

  @override
  String get exportToPDF => 'Export to PDF';

  @override
  String get exportYourTransactionsToPDFFile =>
      'Export your transactions to PDF file';

  @override
  String get clearOldData => 'Clear Old Data';

  @override
  String get removeTransactionsOlderThanASpecificDate =>
      'Remove transactions older than a specific date';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get removeAllTransactionsPermanently =>
      'Remove all transactions permanently';

  @override
  String get about => 'About';

  @override
  String get appVersion => 'App Version';

  @override
  String get appNameSetting => 'App Name';

  @override
  String get account => 'Account';

  @override
  String get signOutOfYourAccount => 'Sign out of your account';

  @override
  String get clearOldDataTitle => 'Clear Old Data';

  @override
  String get clearOldDataMessage =>
      'Select a date. All transactions before this date will be deleted.';

  @override
  String get clearAllDataTitle => 'Clear All Data';

  @override
  String get confirmClearAllData =>
      'Are you sure you want to delete ALL transactions? This action cannot be undone.';

  @override
  String get logoutTitle => 'Logout';

  @override
  String get confirmLogout => 'Are you sure you want to logout?';

  @override
  String get transactionsReport => 'Transactions Report';

  @override
  String generated(String date) {
    return 'Generated: $date';
  }

  @override
  String get summary => 'Summary';

  @override
  String get transactionsExportDate => 'Date';

  @override
  String get transactionsExportType => 'Type';

  @override
  String get transactionsExportCategory => 'Category';

  @override
  String get transactionsExportDescription => 'Description';

  @override
  String get transactionsExportAmount => 'Amount';

  @override
  String get noTransactionsToExport => 'No transactions to export';

  @override
  String get loadingAppInfo => 'Loading...';
}
