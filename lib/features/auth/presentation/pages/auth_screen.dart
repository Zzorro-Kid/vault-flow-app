import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:test_app/features/auth/presentation/widgets/login_form.dart';
import 'package:test_app/features/auth/presentation/widgets/first_setup_password_form.dart';
import 'package:test_app/injection_container.dart';
import 'package:test_app/core/utils/ui_helpers.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>()..checkAuthState(),
      child: BlocListener<AuthCubit, AuthCubitState>(
        listener: (context, state) {
          switch (state) {
            case AuthCubitLoginSuccess() || AuthCubitPasswordSetSuccess():
              Navigator.pushReplacementNamed(context, '/home');
            case AuthCubitError():
              UiHelpers.showErrorSnackBar(context, state.message);
            default:
              break;
          }
        },
        child: Scaffold(body: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state) {
          return switch (state) {
            AuthCubitLoading() ||
            AuthCubitInitial() => const LoadingIndicator(message: 'Loading...'),
            AuthCubitLoaded(:final authState) when authState.isFirstLaunch =>
              const SetupPasswordForm(),
            AuthCubitLoaded() => const LoginForm(),
            _ => const LoginForm(),
          };
        },
      ),
    );
  }
}
