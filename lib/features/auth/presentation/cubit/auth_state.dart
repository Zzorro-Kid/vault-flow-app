part of 'auth_cubit.dart';

abstract class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object?> get props => [];
}

class AuthCubitInitial extends AuthCubitState {}

class AuthCubitLoading extends AuthCubitState {}

class AuthCubitLoaded extends AuthCubitState {
  final AuthStateData authState;

  const AuthCubitLoaded(this.authState);

  @override
  List<Object?> get props => [authState];
}

class AuthCubitPasswordSetSuccess extends AuthCubitState {}

class AuthCubitLoginSuccess extends AuthCubitState {}

class AuthCubitLogoutSuccess extends AuthCubitState {}

class AuthCubitError extends AuthCubitState {
  final String message;

  const AuthCubitError(this.message);

  @override
  List<Object?> get props => [message];
}
