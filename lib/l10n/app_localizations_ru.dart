// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'VaultFlow';

  @override
  String get navHome => 'Главная';

  @override
  String get navAdd => 'Добавить';

  @override
  String get navCategories => 'Категории';

  @override
  String get navStats => 'Статистика';

  @override
  String get navSettings => 'Настройки';

  @override
  String get dashboard => 'Панель управления';

  @override
  String get transactions => 'Транзакции';

  @override
  String get categoriesTitle => 'Категории';

  @override
  String get statistics => 'Статистика';

  @override
  String get settings => 'Настройки';

  @override
  String get noRouteDefined => 'Маршрут не определён';

  @override
  String get loading => 'Загрузка...';

  @override
  String get loadingSettings => 'Загрузка настроек...';

  @override
  String get somethingWentWrong => 'Что-то пошло не так';

  @override
  String get retry => 'Повторить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteAll => 'Удалить всё';

  @override
  String get add => 'Добавить';

  @override
  String get save => 'Сохранить';

  @override
  String get change => 'Изменить';

  @override
  String get clear => 'Очистить';

  @override
  String get logout => 'Выйти';

  @override
  String get unlock => 'Разблокировать';

  @override
  String get createPassword => 'Создать пароль';

  @override
  String get yesReset => 'Да, сбросить';

  @override
  String get expense => 'Расход';

  @override
  String get expense_plural => 'Расходы';

  @override
  String get income => 'Доход';

  @override
  String get income_plural => 'Доходы';

  @override
  String get netBalance => 'Чистый баланс';

  @override
  String get balance => 'Баланс';

  @override
  String get totalIncome => 'Общий доход';

  @override
  String get totalExpenses => 'Общие расходы';

  @override
  String summaryFor(String period) {
    return 'Сводка за $period';
  }

  @override
  String get periodDay => 'День';

  @override
  String get periodWeek => 'Неделя';

  @override
  String get periodMonth => 'Месяц';

  @override
  String get periodYear => 'Год';

  @override
  String get expenseCategories => 'Категории расходов';

  @override
  String get incomeCategories => 'Категории доходов';

  @override
  String get recentTransactions => 'Последние транзакции';

  @override
  String transactionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# транзакций',
      many: '# транзакций',
      few: '# транзакции',
      one: '1 транзакция',
      zero: 'Нет транзакций',
    );
    return '$_temp0';
  }

  @override
  String get categoryBreakdown => 'Разбивка по категориям';

  @override
  String get dailyTrends => 'Ежедневные тенденции';

  @override
  String get noCategoryDataAvailable => 'Нет данных по категориям';

  @override
  String get noTrendDataAvailable => 'Нет данных о тенденциях';

  @override
  String get noCategoriesYet => 'Пока нет категорий';

  @override
  String get noTransactionsYet => 'Пока нет транзакций';

  @override
  String get noCategoriesAvailable => 'Нет доступных категорий';

  @override
  String get selectADate => 'Выберите дату';

  @override
  String get welcomeToVaultFlow => 'Добро пожаловать в VaultFlow';

  @override
  String get enterYourMasterPassword => 'Введите ваш мастер-пароль';

  @override
  String get createMasterPassword => 'Создайте мастер-пароль';

  @override
  String get passwordWillEncryptData => 'Этот пароль зашифрует все ваши данные';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get currentPassword => 'Текущий пароль';

  @override
  String get newPassword => 'Новый пароль';

  @override
  String get confirmNewPassword => 'Подтвердите новый пароль';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get passwordMustBeAtLeast6Characters =>
      'Пароль должен содержать не менее 6 символов';

  @override
  String get pleaseEnterYourCurrentPassword => 'Введите текущий пароль';

  @override
  String get pleaseEnterANewPassword => 'Введите новый пароль';

  @override
  String get pleaseConfirmYourNewPassword => 'Подтвердите новый пароль';

  @override
  String get resetPassword => 'Сбросить пароль';

  @override
  String get resetPasswordWarning =>
      'Это удалит ВСЕ ваши данные, включая транзакции и категории. Вам нужно будет создать новый пароль.\n\nВы уверены, что хотите продолжить?';

  @override
  String get addTransaction => 'Добавить транзакцию';

  @override
  String get editTransaction => 'Редактировать транзакцию';

  @override
  String get deleteTransaction => 'Удалить транзакцию';

  @override
  String confirmDeleteTransaction(String transactionTitle) {
    return 'Вы уверены, что хотите удалить \"$transactionTitle\"?';
  }

  @override
  String get description => 'Описание';

  @override
  String get amount => 'Сумма';

  @override
  String get category => 'Категория';

  @override
  String get date => 'Дата';

  @override
  String get type => 'Тип';

  @override
  String get icon => 'Иконка';

  @override
  String get color => 'Цвет';

  @override
  String get categoryName => 'Название категории';

  @override
  String get pleaseEnterADescription => 'Введите описание';

  @override
  String get pleaseEnterAnAmount => 'Введите сумму';

  @override
  String get pleaseEnterAValidNumber => 'Введите корректное число';

  @override
  String get pleaseSelectACategory => 'Выберите категорию';

  @override
  String get pleaseEnterACategoryName => 'Введите название категории';

  @override
  String get addCategory => 'Добавить категорию';

  @override
  String get editCategory => 'Редактировать категорию';

  @override
  String get deleteCategory => 'Удалить категорию';

  @override
  String confirmDeleteCategory(String categoryName) {
    return 'Вы уверены, что хотите удалить \"$categoryName\"?';
  }

  @override
  String get security => 'Безопасность';

  @override
  String get changePassword => 'Изменить пароль';

  @override
  String get updateYourSecurityPassword => 'Обновите ваш пароль безопасности';

  @override
  String get dataManagement => 'Управление данными';

  @override
  String get exportToCSV => 'Экспорт в CSV';

  @override
  String get exportYourTransactionsToCSVFile =>
      'Экспортируйте ваши транзакции в файл CSV';

  @override
  String get exportToPDF => 'Экспорт в PDF';

  @override
  String get exportYourTransactionsToPDFFile =>
      'Экспортируйте ваши транзакции в файл PDF';

  @override
  String get clearOldData => 'Очистить старые данные';

  @override
  String get removeTransactionsOlderThanASpecificDate =>
      'Удалить транзакции старше указанной даты';

  @override
  String get clearAllData => 'Очистить все данные';

  @override
  String get removeAllTransactionsPermanently =>
      'Удалить все транзакции навсегда';

  @override
  String get about => 'О приложении';

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get appNameSetting => 'Название приложения';

  @override
  String get account => 'Аккаунт';

  @override
  String get signOutOfYourAccount => 'Выйти из аккаунта';

  @override
  String get clearOldDataTitle => 'Очистить старые данные';

  @override
  String get clearOldDataMessage =>
      'Выберите дату. Все транзакции до этой даты будут удалены.';

  @override
  String get clearAllDataTitle => 'Очистить все данные';

  @override
  String get confirmClearAllData =>
      'Вы уверены, что хотите удалить ВСЕ транзакции? Это действие нельзя отменить.';

  @override
  String get logoutTitle => 'Выход';

  @override
  String get confirmLogout => 'Вы уверены, что хотите выйти?';

  @override
  String get transactionsReport => 'Отчёт о транзакциях';

  @override
  String generated(String date) {
    return 'Создано: $date';
  }

  @override
  String get summary => 'Сводка';

  @override
  String get transactionsExportDate => 'Дата';

  @override
  String get transactionsExportType => 'Тип';

  @override
  String get transactionsExportCategory => 'Категория';

  @override
  String get transactionsExportDescription => 'Описание';

  @override
  String get transactionsExportAmount => 'Сумма';

  @override
  String get noTransactionsToExport => 'Нет транзакций для экспорта';

  @override
  String get loadingAppInfo => 'Загрузка...';
}
