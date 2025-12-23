import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/routes/app_routes.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:test_app/features/auth/presentation/widgets/login_form.dart';
import 'package:test_app/features/auth/presentation/widgets/setup_password_form.dart';
import 'package:test_app/injection_container.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>()..checkAuthState(),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<AuthCubit, AuthCubitState>(
            listener: (context, state) {
              switch (state) {
                case AuthCubitLoginSuccess() || AuthCubitPasswordSetSuccess():
                  Navigator.pushReplacementNamed(context, AppRouter.home);
                case AuthCubitError():
                  _showError(context, state.message);
                default:
                  break;
              }
            },
            child: BlocBuilder<AuthCubit, AuthCubitState>(
              builder: (context, state) {
                return switch (state) {
                  AuthCubitLoading() || AuthCubitInitial() =>
                    const LoadingIndicator(message: 'Loading...'),
                  AuthCubitLoaded(:final authState)
                      when authState.isFirstLaunch || !authState.hasPassword =>
                    const SetupPasswordForm(),
                  AuthCubitLoaded(:final authState) => LoginForm(
                    useBiometric: authState.useBiometric,
                  ),
                  _ => const LoginForm(useBiometric: false),
                };
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
