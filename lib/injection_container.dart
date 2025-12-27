import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/core/secure_prefs.dart';
import 'package:test_app/core/shared_prefs.dart';
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
import 'package:test_app/features/add_transaction/data/repositories/transaction_repository_impl.dart';
import 'package:test_app/features/add_transaction/data/sources/transaction_local_data_source.dart';
import 'package:test_app/features/add_transaction/domain/repositories/transaction_repository.dart';
import 'package:test_app/features/add_transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:test_app/features/add_transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:test_app/features/add_transaction/domain/usecases/get_all_transactions_usecase.dart';
import 'package:test_app/features/add_transaction/domain/usecases/update_transaction_usecase.dart';
import 'package:test_app/features/add_transaction/presentation/cubit/transaction_cubit.dart';
import 'package:test_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:test_app/features/home/data/sources/home_local_data_source.dart';
import 'package:test_app/features/home/domain/repositories/home_repository.dart';
import 'package:test_app/features/home/domain/usecases/get_dashboard_summary_usecase.dart';
import 'package:test_app/features/home/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initCore();
  _initAuth();
  _initHome();
  _initCategory();
  _initTransaction();
}

Future<void> _initCore() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => secureStorage);

  sl.registerLazySingleton(() => SharedPrefs(sl()));
  sl.registerLazySingleton(() => SecurePrefs(sl()));
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
    () => AuthLocalDataSourceImpl(sharedPrefs: sl(), securePrefs: sl()),
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
    () => HomeLocalDataSourceImpl(securePrefs: sl()),
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
    () => CategoryLocalDataSourceImpl(securePrefs: sl()),
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
    () => TransactionLocalDataSourceImpl(securePrefs: sl()),
  );
}
