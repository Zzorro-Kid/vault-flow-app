// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'VaultFlow';

  @override
  String get navHome => 'Головна';

  @override
  String get navAdd => 'Додати';

  @override
  String get navCategories => 'Категорії';

  @override
  String get navStats => 'Статистика';

  @override
  String get navSettings => 'Налаштування';

  @override
  String get dashboard => 'Панель керування';

  @override
  String get transactions => 'Транзакції';

  @override
  String get categoriesTitle => 'Категорії';

  @override
  String get statistics => 'Статистика';

  @override
  String get settings => 'Налаштування';

  @override
  String get noRouteDefined => 'Маршрут не визначено';

  @override
  String get loading => 'Завантаження...';

  @override
  String get loadingSettings => 'Завантаження налаштувань...';

  @override
  String get somethingWentWrong => 'Щось пішло не так';

  @override
  String get retry => 'Повторити';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get deleteAll => 'Видалити все';

  @override
  String get add => 'Додати';

  @override
  String get save => 'Зберегти';

  @override
  String get change => 'Змінити';

  @override
  String get clear => 'Очистити';

  @override
  String get logout => 'Вийти';

  @override
  String get unlock => 'Розблокувати';

  @override
  String get createPassword => 'Створити пароль';

  @override
  String get yesReset => 'Так, скинути';

  @override
  String get expense => 'Витрата';

  @override
  String get expense_plural => 'Витрати';

  @override
  String get income => 'Дохід';

  @override
  String get income_plural => 'Доходи';

  @override
  String get netBalance => 'Чистий баланс';

  @override
  String get balance => 'Баланс';

  @override
  String get totalIncome => 'Загальний дохід';

  @override
  String get totalExpenses => 'Загальні витрати';

  @override
  String summaryFor(String period) {
    return 'Підсумок за $period';
  }

  @override
  String get periodDay => 'День';

  @override
  String get periodWeek => 'Тиждень';

  @override
  String get periodMonth => 'Місяць';

  @override
  String get periodYear => 'Рік';

  @override
  String get expenseCategories => 'Категорії витрат';

  @override
  String get incomeCategories => 'Категорії доходів';

  @override
  String get recentTransactions => 'Останні транзакції';

  @override
  String transactionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# транзакцій',
      many: '# транзакцій',
      few: '# транзакції',
      one: '# транзакція',
      zero: 'Немає транзакцій',
    );
    return '$_temp0';
  }

  @override
  String get categoryBreakdown => 'Розподіл за категоріями';

  @override
  String get dailyTrends => 'Щоденні тренди';

  @override
  String get noCategoryDataAvailable => 'Немає даних за категоріями';

  @override
  String get noTrendDataAvailable => 'Немає даних про тренди';

  @override
  String get noCategoriesYet => 'Ще немає категорій';

  @override
  String get noTransactionsYet => 'Ще немає транзакцій';

  @override
  String get noCategoriesAvailable => 'Немає доступних категорій';

  @override
  String get selectADate => 'Виберіть дату';

  @override
  String get welcomeToVaultFlow => 'Ласкаво просимо до VaultFlow';

  @override
  String get enterYourMasterPassword => 'Введіть ваш майстер-пароль';

  @override
  String get createMasterPassword => 'Створіть майстер-пароль';

  @override
  String get passwordWillEncryptData => 'Цей пароль зашифрує всі ваші дані';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Підтвердіть пароль';

  @override
  String get currentPassword => 'Поточний пароль';

  @override
  String get newPassword => 'Новий пароль';

  @override
  String get confirmNewPassword => 'Підтвердіть новий пароль';

  @override
  String get passwordsDoNotMatch => 'Паролі не співпадають';

  @override
  String get passwordMustBeAtLeast6Characters =>
      'Пароль має містити принаймні 6 символів';

  @override
  String get pleaseEnterYourCurrentPassword => 'Введіть поточний пароль';

  @override
  String get pleaseEnterANewPassword => 'Введіть новий пароль';

  @override
  String get pleaseConfirmYourNewPassword => 'Підтвердіть новий пароль';

  @override
  String get resetPassword => 'Скинути пароль';

  @override
  String get resetPasswordWarning =>
      'Це видалить ВСІ ваші дані, включаючи транзакції та категорії. Вам потрібно буде створити новий пароль.\n\nВи впевнені, що хочете продовжити?';

  @override
  String get addTransaction => 'Додати транзакцію';

  @override
  String get editTransaction => 'Редагувати транзакцію';

  @override
  String get deleteTransaction => 'Видалити транзакцію';

  @override
  String confirmDeleteTransaction(String transactionTitle) {
    return 'Ви впевнені, що хочете видалити \"$transactionTitle\"?';
  }

  @override
  String get description => 'Опис';

  @override
  String get amount => 'Сума';

  @override
  String get category => 'Категория';

  @override
  String get date => 'Дата';

  @override
  String get type => 'Тип';

  @override
  String get icon => 'Іконка';

  @override
  String get color => 'Колір';

  @override
  String get categoryName => 'Назва категорії';

  @override
  String get pleaseEnterADescription => 'Введіть опис';

  @override
  String get pleaseEnterAnAmount => 'Введіть суму';

  @override
  String get pleaseEnterAValidNumber => 'Введіть коректне число';

  @override
  String get pleaseSelectACategory => 'Виберіть категорію';

  @override
  String get pleaseEnterACategoryName => 'Введіть назву категорії';

  @override
  String get addCategory => 'Додати категорію';

  @override
  String get editCategory => 'Редагувати категорію';

  @override
  String get deleteCategory => 'Видалити категорію';

  @override
  String confirmDeleteCategory(String categoryName) {
    return 'Ви впевнені, що хочете видалити \"$categoryName\"?';
  }

  @override
  String get security => 'Безпека';

  @override
  String get changePassword => 'Змінити пароль';

  @override
  String get updateYourSecurityPassword => 'Оновіть ваш пароль безпеки';

  @override
  String get dataManagement => 'Керування даними';

  @override
  String get exportToCSV => 'Експорт у CSV';

  @override
  String get exportYourTransactionsToCSVFile =>
      'Експортуйте ваші транзакції у файл CSV';

  @override
  String get exportToPDF => 'Експорт у PDF';

  @override
  String get exportYourTransactionsToPDFFile =>
      'Експортуйте ваші транзакції у файл PDF';

  @override
  String get clearOldData => 'Очистити старі дані';

  @override
  String get removeTransactionsOlderThanASpecificDate =>
      'Видалити транзакції старші за вказану дату';

  @override
  String get clearAllData => 'Очистити всі дані';

  @override
  String get removeAllTransactionsPermanently =>
      'Видалити всі транзакції назавжди';

  @override
  String get about => 'Про додаток';

  @override
  String get appVersion => 'Версія додатку';

  @override
  String get appNameSetting => 'Назва додатку';

  @override
  String get account => 'Акаунт';

  @override
  String get signOutOfYourAccount => 'Вийти з акаунту';

  @override
  String get clearOldDataTitle => 'Очистити старі дані';

  @override
  String get clearOldDataMessage =>
      'Виберіть дату. Всі транзакції до цієї дати будуть видалені.';

  @override
  String get clearAllDataTitle => 'Очистити всі дані';

  @override
  String get confirmClearAllData =>
      'Ви впевнені, що хочете видалити ВСІ транзакції? Цю дію не можна скасувати.';

  @override
  String get logoutTitle => 'Вихід';

  @override
  String get confirmLogout => 'Ви впевнені, що хочете вийти?';

  @override
  String get transactionsReport => 'Звіт про транзакції';

  @override
  String generated(String date) {
    return 'Створено: $date';
  }

  @override
  String get summary => 'Підсумок';

  @override
  String get transactionsExportDate => 'Дата';

  @override
  String get transactionsExportType => 'Тип';

  @override
  String get transactionsExportCategory => 'Категория';

  @override
  String get transactionsExportDescription => 'Опис';

  @override
  String get transactionsExportAmount => 'Сума';

  @override
  String get noTransactionsToExport => 'Немає транзакцій для експорту';

  @override
  String get loadingAppInfo => 'Завантаження...';

  @override
  String get languageSettings => 'Мова';

  @override
  String get appLanguage => 'Мова додатку';

  @override
  String get useSystemLanguage => 'Використовувати системну мову';

  @override
  String get selectLanguage => 'Виберіть мову';

  @override
  String get english => 'Англійська';

  @override
  String get russian => 'Російська';

  @override
  String get ukrainian => 'Українська';

  @override
  String get german => 'Німецька';

  @override
  String get french => 'Французька';

  @override
  String get languageChangeSuccess => 'Мова успішно змінена';

  @override
  String systemLanguageDetected(String language) {
    return 'Виявлено системну мову: $language';
  }

  @override
  String get unsupportedSystemLanguage =>
      'Ваша системна мова не повністю підтримується. Використовується англійська.';
}
