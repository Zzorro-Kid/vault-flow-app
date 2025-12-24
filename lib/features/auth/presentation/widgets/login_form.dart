import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/utils/validators.dart';
import 'package:test_app/core/widgets/custom_button.dart';
import 'package:test_app/core/widgets/custom_text_field.dart';
import 'package:test_app/features/auth/presentation/cubit/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // RESET BUTTON (TEMPORARY)
            TextButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
              child: const Text('Reset App (Debug)'),
            ),
            _buildIcon(),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildTitle(),
            const SizedBox(height: AppDimensions.spacingSmall),
            _buildSubtitle(),
            const SizedBox(height: AppDimensions.spacingXLarge),
            _buildPasswordField(),
            const SizedBox(height: AppDimensions.spacingXLarge),
            _buildUnlockButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      Icons.shield_outlined,
      size: AppDimensions.iconXLarge * 2,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildTitle() {
    return Text(
      'Welcome to VaultFlow',
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Enter your master password',
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      label: 'Password',
      controller: _passwordController,
      obscureText: _obscurePassword,
      validator: Validators.validatePassword,
      suffixIcon: IconButton(
        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() => _obscurePassword = !_obscurePassword);
        },
      ),
    );
  }

  Widget _buildUnlockButton() {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        return CustomButton(
          text: 'Unlock',
          onPressed: _submit,
          isLoading: state is AuthCubitLoading,
        );
      },
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(_passwordController.text);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
