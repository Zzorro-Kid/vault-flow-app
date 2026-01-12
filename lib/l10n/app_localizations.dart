import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('ru'),
    Locale('uk'),
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'VaultFlow'**
  String get appName;

  /// Home navigation label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Add navigation label
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get navAdd;

  /// Categories navigation label
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get navCategories;

  /// Statistics navigation label
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navStats;

  /// Settings navigation label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Dashboard screen title
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// Transactions screen title
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// Categories screen title
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// Statistics screen title
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Error message for undefined routes
  ///
  /// In en, this message translates to:
  /// **'No route defined for this path'**
  String get noRouteDefined;

  /// Loading indicator message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Loading settings message
  ///
  /// In en, this message translates to:
  /// **'Loading settings...'**
  String get loadingSettings;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// Retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Delete all button label
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// Add button label
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Change button label
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// Clear button label
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Logout button label
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Unlock button label
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// Create password button label
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get createPassword;

  /// Confirm reset button label
  ///
  /// In en, this message translates to:
  /// **'Yes, Reset'**
  String get yesReset;

  /// Expenses plural label
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @expense_plural.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expense_plural;

  /// Incomes plural label
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @income_plural.
  ///
  /// In en, this message translates to:
  /// **'Incomes'**
  String get income_plural;

  /// Net balance label
  ///
  /// In en, this message translates to:
  /// **'Net Balance'**
  String get netBalance;

  /// Balance label
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// Total income label
  ///
  /// In en, this message translates to:
  /// **'Total Income'**
  String get totalIncome;

  /// Total expenses label
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get totalExpenses;

  /// Summary period label
  ///
  /// In en, this message translates to:
  /// **'Summary for {period}'**
  String summaryFor(String period);

  /// Day period label
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get periodDay;

  /// Week period label
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get periodWeek;

  /// Month period label
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get periodMonth;

  /// Year period label
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get periodYear;

  /// Expense categories section header
  ///
  /// In en, this message translates to:
  /// **'Expense Categories'**
  String get expenseCategories;

  /// Income categories section header
  ///
  /// In en, this message translates to:
  /// **'Income Categories'**
  String get incomeCategories;

  /// Recent transactions section header
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// Transaction count with pluralization
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No transactions} =1{1 transaction} other{{count} transactions}}'**
  String transactionsCount(int count);

  /// Category breakdown chart title
  ///
  /// In en, this message translates to:
  /// **'Category Breakdown'**
  String get categoryBreakdown;

  /// Daily trends chart title
  ///
  /// In en, this message translates to:
  /// **'Daily Trends'**
  String get dailyTrends;

  /// Empty state message for category breakdown
  ///
  /// In en, this message translates to:
  /// **'No category data available'**
  String get noCategoryDataAvailable;

  /// Empty state message for daily trends
  ///
  /// In en, this message translates to:
  /// **'No trend data available'**
  String get noTrendDataAvailable;

  /// Empty state message for categories
  ///
  /// In en, this message translates to:
  /// **'No categories yet'**
  String get noCategoriesYet;

  /// Empty state message for transactions
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactionsYet;

  /// Empty state message for category selector
  ///
  /// In en, this message translates to:
  /// **'No categories available'**
  String get noCategoriesAvailable;

  /// Select date placeholder
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get selectADate;

  /// Welcome title on login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to VaultFlow'**
  String get welcomeToVaultFlow;

  /// Subtitle on login screen
  ///
  /// In en, this message translates to:
  /// **'Enter your master password'**
  String get enterYourMasterPassword;

  /// Title on password setup screen
  ///
  /// In en, this message translates to:
  /// **'Create Master Password'**
  String get createMasterPassword;

  /// Subtitle on password setup screen
  ///
  /// In en, this message translates to:
  /// **'This password will encrypt all your data'**
  String get passwordWillEncryptData;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Current password field label
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Confirm new password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// Validation error for mismatched passwords
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Validation error for short password
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMustBeAtLeast6Characters;

  /// Validation error for empty current password
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password'**
  String get pleaseEnterYourCurrentPassword;

  /// Validation error for empty new password
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password'**
  String get pleaseEnterANewPassword;

  /// Validation error for empty confirm password
  ///
  /// In en, this message translates to:
  /// **'Please confirm your new password'**
  String get pleaseConfirmYourNewPassword;

  /// Reset password button label
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Warning message for password reset
  ///
  /// In en, this message translates to:
  /// **'This will delete ALL your data including transactions and categories. You will need to create a new password.\n\nAre you sure you want to continue?'**
  String get resetPasswordWarning;

  /// Add transaction dialog title
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get addTransaction;

  /// Edit transaction dialog title
  ///
  /// In en, this message translates to:
  /// **'Edit Transaction'**
  String get editTransaction;

  /// Delete transaction dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get deleteTransaction;

  /// Confirm delete transaction message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{transactionTitle}\"?'**
  String confirmDeleteTransaction(String transactionTitle);

  /// Description field label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Amount field label
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Category field label
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Date field label
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Type field label
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// Icon field label
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// Color field label
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// Category name field label
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// Validation error for empty description
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get pleaseEnterADescription;

  /// Validation error for empty amount
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get pleaseEnterAnAmount;

  /// Validation error for invalid number
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get pleaseEnterAValidNumber;

  /// Validation error for empty category
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get pleaseSelectACategory;

  /// Validation error for empty category name
  ///
  /// In en, this message translates to:
  /// **'Please enter a category name'**
  String get pleaseEnterACategoryName;

  /// Add category dialog title
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// Edit category dialog title
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// Delete category dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategory;

  /// Confirm delete category message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{categoryName}\"?'**
  String confirmDeleteCategory(String categoryName);

  /// Security settings section title
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// Change password setting title
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Change password setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Update your security password'**
  String get updateYourSecurityPassword;

  /// Data management settings section title
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// Export to CSV setting title
  ///
  /// In en, this message translates to:
  /// **'Export to CSV'**
  String get exportToCSV;

  /// Export to CSV setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Export your transactions to CSV file'**
  String get exportYourTransactionsToCSVFile;

  /// Export to PDF setting title
  ///
  /// In en, this message translates to:
  /// **'Export to PDF'**
  String get exportToPDF;

  /// Export to PDF setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Export your transactions to PDF file'**
  String get exportYourTransactionsToPDFFile;

  /// Clear old data setting title
  ///
  /// In en, this message translates to:
  /// **'Clear Old Data'**
  String get clearOldData;

  /// Clear old data setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Remove transactions older than a specific date'**
  String get removeTransactionsOlderThanASpecificDate;

  /// Clear all data setting title
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// Clear all data setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Remove all transactions permanently'**
  String get removeAllTransactionsPermanently;

  /// About settings section title
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// App version setting title
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// App name setting title
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get appNameSetting;

  /// Account settings section title
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Logout setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get signOutOfYourAccount;

  /// Clear old data dialog title
  ///
  /// In en, this message translates to:
  /// **'Clear Old Data'**
  String get clearOldDataTitle;

  /// Clear old data dialog message
  ///
  /// In en, this message translates to:
  /// **'Select a date. All transactions before this date will be deleted.'**
  String get clearOldDataMessage;

  /// Clear all data dialog title
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllDataTitle;

  /// Clear all data dialog content
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete ALL transactions? This action cannot be undone.'**
  String get confirmClearAllData;

  /// Logout dialog title
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// Logout dialog content
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmLogout;

  /// PDF report header
  ///
  /// In en, this message translates to:
  /// **'Transactions Report'**
  String get transactionsReport;

  /// PDF generation date
  ///
  /// In en, this message translates to:
  /// **'Generated: {date}'**
  String generated(String date);

  /// Summary section header
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// CSV/PDF export date column header
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get transactionsExportDate;

  /// CSV/PDF export type column header
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get transactionsExportType;

  /// CSV/PDF export category column header
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get transactionsExportCategory;

  /// CSV/PDF export description column header
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get transactionsExportDescription;

  /// CSV/PDF export amount column header
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get transactionsExportAmount;

  /// Error message when no transactions to export
  ///
  /// In en, this message translates to:
  /// **'No transactions to export'**
  String get noTransactionsToExport;

  /// Loading app info message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingAppInfo;

  /// Language settings section title
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSettings;

  /// App language setting label
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// Toggle to use system language preference
  ///
  /// In en, this message translates to:
  /// **'Use System Language'**
  String get useSystemLanguage;

  /// Dialog title for language selection
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Russian language option
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// Ukrainian language option
  ///
  /// In en, this message translates to:
  /// **'Ukrainian'**
  String get ukrainian;

  /// German language option
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// French language option
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// Success message after language change
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully'**
  String get languageChangeSuccess;

  /// Message when system language is detected
  ///
  /// In en, this message translates to:
  /// **'System language detected: {language}'**
  String systemLanguageDetected(String language);

  /// Warning when system language is not supported
  ///
  /// In en, this message translates to:
  /// **'Your system language is not fully supported. Using English instead.'**
  String get unsupportedSystemLanguage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'fr', 'ru', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
