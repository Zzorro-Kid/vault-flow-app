import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/routes/app_routes.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/auth/domain/entities/auth_state_data.dart';
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
          child: BlocConsumer<AuthCubit, AuthCubitState>(
            listener: _listener,
            builder: _builder,
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, AuthCubitState state) {
    if (state is AuthCubitLoginSuccess ||
        state is AuthCubitPasswordSetSuccess) {
      _navigateToHome(context);
    } else if (state is AuthCubitError) {
      _showErrorSnackBar(context, state.message);
    }
  }

  Widget _builder(BuildContext context, AuthCubitState state) {
    if (state is AuthCubitLoading || state is AuthCubitInitial) {
      return const LoadingIndicator(message: 'Loading...');
    }

    if (state is AuthCubitLoaded) {
      return _buildFormByAuthState(state.authState);
    }

    return const LoginForm(useBiometric: false);
  }

  Widget _buildFormByAuthState(AuthStateData authState) {
    if (authState.isFirstLaunch || !authState.hasPassword) {
      return const SetupPasswordForm();
    }
    return LoginForm(useBiometric: authState.useBiometric);
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRouter.home);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
