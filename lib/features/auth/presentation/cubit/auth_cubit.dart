import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/auth/domain/entities/auth_state_data.dart';
import 'package:test_app/features/auth/domain/usecases/clear_auth_data_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/complete_first_launch_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/set_password_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/verify_password_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final GetAuthStateUseCase getAuthStateUseCase;
  final SetPasswordUseCase setPasswordUseCase;
  final VerifyPasswordUseCase verifyPasswordUseCase;
  final CompleteFirstLaunchUseCase completeFirstLaunchUseCase;
  final ClearAuthDataUseCase clearAuthDataUseCase;

  AuthCubit({
    required this.getAuthStateUseCase,
    required this.setPasswordUseCase,
    required this.verifyPasswordUseCase,
    required this.completeFirstLaunchUseCase,
    required this.clearAuthDataUseCase,
  }) : super(AuthCubitInitial());

  Future<void> checkAuthState() async {
    emit(AuthCubitLoading());

    final result = await getAuthStateUseCase(NoParams());

    result.fold(
      (failure) => emit(AuthCubitError(failure.message)),
      (authState) => emit(AuthCubitLoaded(authState)),
    );
  }

  Future<void> setupPassword(String password) async {
    emit(AuthCubitLoading());

    final result = await setPasswordUseCase(password);

    result.fold((failure) => emit(AuthCubitError(failure.message)), (_) async {
      await completeFirstLaunchUseCase();
      await checkAuthState();
      emit(AuthCubitPasswordSetSuccess());
    });
  }

  Future<void> login(String password) async {
    emit(AuthCubitLoading());

    final result = await verifyPasswordUseCase(password);

    result.fold((failure) => emit(AuthCubitError(failure.message)), (isValid) {
      if (isValid) {
        emit(AuthCubitLoginSuccess());
      } else {
        emit(const AuthCubitError('Invalid password'));
      }
    });
  }

  // logout: I'll move it to settings cubit
  Future<void> logout() async {
    emit(AuthCubitLoading());

    final result = await clearAuthDataUseCase();

    result.fold((failure) => emit(AuthCubitError(failure.message)), (_) {
      emit(AuthCubitLogoutSuccess());
      checkAuthState();
    });
  }
}
