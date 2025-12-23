import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/core/blocs/theme_change_cubit/theme_cubit.dart';
import 'package:test_app/core/secure_prefs.dart';
import 'package:test_app/core/shared_prefs.dart';
import 'package:test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:test_app/features/auth/data/sources/auth_local_data_source.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_app/features/auth/domain/usecases/clear_auth_data_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/complete_first_launch_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/set_password_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/verify_password_usecase.dart';
import 'package:test_app/features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initCore();
  _initAuth();
}

Future<void> _initCore() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => secureStorage);

  sl.registerLazySingleton(() => SharedPrefs(sl()));
  sl.registerLazySingleton(() => SecurePrefs(sl()));

  sl.registerLazySingleton(() => ThemeCubit(sharedPrefs: sl()));
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
