import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/core/secure_prefs.dart';
import 'package:test_app/core/shared_prefs.dart';
import 'package:test_app/core/services/storage_service.dart';
import 'package:test_app/core/services/auth_service.dart';
import 'package:test_app/core/services/export_service.dart';
import 'package:test_app/core/services/financial_service.dart';
import 'package:test_app/core/services/locale_service.dart';
import 'package:test_app/core/usecases/get_recent_transactions_usecase.dart';
import 'package:test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:test_app/features/auth/data/sources/auth_local_data_source.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_app/features/auth/domain/usecases/clear_auth_data_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/complete_first_launch_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/set_password_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/verify_password_usecase.dart';
import 'package:test_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:test_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:test_app/features/category/data/sources/category_local_data_source.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';
import 'package:test_app/features/category/domain/usecases/add_category_usecase.dart';
import 'package:test_app/features/category/domain/usecases/delete_category_usecase.dart';
import 'package:test_app/features/category/domain/usecases/get_all_categories_usecase.dart';
import 'package:test_app/features/category/domain/usecases/update_category_usecase.dart';
import 'package:test_app/features/category/presentation/cubit/category_cubit.dart';
import 'package:test_app/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:test_app/features/transaction/data/sources/transaction_local_data_source.dart';
import 'package:test_app/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:test_app/features/transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:test_app/features/transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:test_app/features/transaction/domain/usecases/get_all_transactions_usecase.dart';
import 'package:test_app/features/transaction/domain/usecases/update_transaction_usecase.dart';
import 'package:test_app/features/transaction/presentation/cubit/transaction_cubit.dart';
import 'package:test_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:test_app/features/home/data/sources/home_local_data_source.dart';
import 'package:test_app/features/home/domain/repositories/home_repository.dart';
import 'package:test_app/features/home/domain/usecases/get_dashboard_summary_usecase.dart';
import 'package:test_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:test_app/features/statistics/data/repositories/statistics_repository_impl.dart';
import 'package:test_app/features/statistics/data/sources/statistics_local_data_source.dart';
import 'package:test_app/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:test_app/features/statistics/domain/usecases/get_statistics_usecase.dart';
import 'package:test_app/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:test_app/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:test_app/features/settings/data/sources/settings_local_data_source.dart';
import 'package:test_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:test_app/features/settings/domain/usecases/get_user_settings.dart';
import 'package:test_app/features/settings/domain/usecases/save_user_settings.dart';
import 'package:test_app/features/settings/domain/usecases/get_app_language.dart';
import 'package:test_app/features/settings/domain/usecases/set_app_language.dart';
import 'package:test_app/features/settings/domain/usecases/get_use_system_language.dart';
import 'package:test_app/features/settings/domain/usecases/set_use_system_language.dart';
import 'package:test_app/features/settings/domain/usecases/update_currency.dart';
import 'package:test_app/features/settings/domain/usecases/update_report_frequency.dart';
import 'package:test_app/features/settings/domain/usecases/change_password.dart';
import 'package:test_app/features/settings/domain/usecases/export_data_to_csv.dart';
import 'package:test_app/features/settings/domain/usecases/export_data_to_pdf.dart';
import 'package:test_app/features/settings/domain/usecases/clear_old_data.dart';
import 'package:test_app/features/settings/domain/usecases/clear_all_data.dart';
import 'package:test_app/features/settings/domain/usecases/get_app_info.dart';
import 'package:test_app/features/settings/domain/usecases/logout.dart';
import 'package:test_app/features/settings/presentation/cubit/settings_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initCore();
  _initAuth();
  _initHome();
  _initCategory();
  _initTransaction();
  _initStatistics();
  _initSettings();
}

Future<void> _initCore() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => secureStorage);

  sl.registerLazySingleton(() => SharedPrefs(sl()));
  sl.registerLazySingleton(() => SecurePrefs(sl()));

  sl.registerLazySingleton(() => StorageService(securePrefs: sl()));
  sl.registerLazySingleton(() => const AuthService());
  sl.registerLazySingleton(() => FinancialService());
  sl.registerLazySingleton(() => LocaleService(prefs: sl()));
  sl.registerLazySingleton(
    () => ExportService(
      calculateFinancialSummary:
          sl<FinancialService>().calculateFinancialSummary,
      getNoTransactionsMessage: () => 'No transactions to export',
      getTransactionsReportTitle: () => 'Transactions Report',
      getGeneratedMessage: (date) => 'Generated: $date',
      getSummaryTitle: () => 'Summary',
      getTotalIncomeMessage: (income) =>
          'Total Income: \$${income.toStringAsFixed(2)}',
      getTotalExpensesMessage: (expenses) =>
          'Total Expenses: \$${expenses.toStringAsFixed(2)}',
      getBalanceMessage: (balance) =>
          'Balance: \$${balance.toStringAsFixed(2)}',
      getDateHeader: () => 'Date',
      getTypeHeader: () => 'Type',
      getCategoryHeader: () => 'Category',
      getDescriptionHeader: () => 'Description',
      getAmountHeader: () => 'Amount',
    ),
  );
}

void _initAuth() {
  sl.registerFactory(
    () => AuthCubit(
      getAuthStateUseCase: sl(),
      setPasswordUseCase: sl(),
      verifyPasswordUseCase: sl(),
      completeFirstLaunchUseCase: sl(),
      clearAuthDataUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAuthStateUseCase(sl()));
  sl.registerLazySingleton(() => SetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPasswordUseCase(sl()));
  sl.registerLazySingleton(() => CompleteFirstLaunchUseCase(sl()));
  sl.registerLazySingleton(() => ClearAuthDataUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPrefs: sl(),
      securePrefs: sl(),
      authService: sl(),
    ),
  );
}

void _initHome() {
  sl.registerFactory(
    () => HomeCubit(
      getDashboardSummaryUseCase: sl(),
      getRecentTransactionsUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetDashboardSummaryUseCase(sl()));
  sl.registerLazySingleton(() => GetRecentTransactionsUseCase(sl()));

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(storageService: sl(), financialService: sl()),
  );
}

void _initCategory() {
  sl.registerFactory(
    () => CategoryCubit(
      getAllCategoriesUseCase: sl(),
      addCategoryUseCase: sl(),
      updateCategoryUseCase: sl(),
      deleteCategoryUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAllCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => AddCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(sl()));

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(storageService: sl()),
  );
}

void _initTransaction() {
  sl.registerFactory(
    () => TransactionCubit(
      getAllTransactionsUseCase: sl(),
      addTransactionUseCase: sl(),
      updateTransactionUseCase: sl(),
      deleteTransactionUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAllTransactionsUseCase(sl()));
  sl.registerLazySingleton(() => AddTransactionUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTransactionUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTransactionUseCase(sl()));

  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(storageService: sl()),
  );
}

void _initStatistics() {
  sl.registerFactory(() => StatisticsCubit(getStatisticsUseCase: sl()));

  sl.registerLazySingleton(() => GetStatisticsUseCase(sl()));

  sl.registerLazySingleton<StatisticsRepository>(
    () => StatisticsRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<StatisticsLocalDataSource>(
    () => StatisticsLocalDataSourceImpl(
      storageService: sl(),
      financialService: sl(),
    ),
  );
}

void _initSettings() {
  sl.registerLazySingleton(
    () => SettingsCubit(
      getUserSettings: sl(),
      saveUserSettings: sl(),
      updateCurrency: sl(),
      updateReportFrequency: sl(),
      getAppLanguage: sl(),
      setAppLanguage: sl(),
      getUseSystemLanguage: sl(),
      setUseSystemLanguage: sl(),
      changePassword: sl(),
      exportDataToCSV: sl(),
      exportDataToPDF: sl(),
      clearOldData: sl(),
      clearAllData: sl(),
      getAppInfo: sl(),
      logout: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetUserSettings(sl()));
  sl.registerLazySingleton(() => SaveUserSettings(sl()));
  sl.registerLazySingleton(() => GetAppLanguage(sl()));
  sl.registerLazySingleton(() => SetAppLanguage(sl()));
  sl.registerLazySingleton(() => GetUseSystemLanguage(sl()));
  sl.registerLazySingleton(() => SetUseSystemLanguage(sl()));
  sl.registerLazySingleton(() => UpdateCurrency(sl()));
  sl.registerLazySingleton(() => UpdateReportFrequency(sl()));
  sl.registerLazySingleton(() => ChangePassword(sl()));
  sl.registerLazySingleton(() => ExportDataToCSV(sl()));
  sl.registerLazySingleton(() => ExportDataToPDF(sl()));
  sl.registerLazySingleton(() => ClearOldData(sl()));
  sl.registerLazySingleton(() => ClearAllData(sl()));
  sl.registerLazySingleton(() => GetAppInfo(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(
      securePrefs: sl(),
      storageService: sl(),
      authService: sl(),
      exportService: sl(),
      sharedPreferences: sl(),
    ),
  );
}
