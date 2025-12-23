import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/utils/validators.dart';
import 'package:test_app/core/widgets/custom_button.dart';
import 'package:test_app/core/widgets/custom_text_field.dart';
import 'package:test_app/features/auth/presentation/cubit/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  final bool useBiometric;

  const LoginForm({super.key, required this.useBiometric});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(_passwordController.text);
    }
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // RESET BUTTON
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
            if (widget.useBiometric) ...[
              const SizedBox(height: AppDimensions.spacingMedium),
              _buildBiometricButton(),
            ],
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
        onPressed: _togglePasswordVisibility,
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

  Widget _buildBiometricButton() {
    return CustomButton(
      text: 'Use Biometric',
      onPressed: () {
        // TODO: Implement biometric authentication
      },
      isOutlined: true,
      icon: Icons.fingerprint,
    );
  }
}
