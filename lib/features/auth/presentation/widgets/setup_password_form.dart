import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/utils/validators.dart';
import 'package:test_app/core/widgets/custom_button.dart';
import 'package:test_app/core/widgets/custom_text_field.dart';
import 'package:test_app/features/auth/presentation/cubit/auth_cubit.dart';

class SetupPasswordForm extends StatefulWidget {
  const SetupPasswordForm({super.key});

  @override
  State<SetupPasswordForm> createState() => _SetupPasswordFormState();
}

class _SetupPasswordFormState extends State<SetupPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
            _buildIcon(),
            const SizedBox(height: AppDimensions.spacingLarge),
            _buildTitle(),
            const SizedBox(height: AppDimensions.spacingSmall),
            _buildSubtitle(),
            const SizedBox(height: AppDimensions.spacingXLarge),
            _buildPasswordField(),
            const SizedBox(height: AppDimensions.spacingMedium),
            _buildConfirmPasswordField(),
            const SizedBox(height: AppDimensions.spacingXLarge),
            _buildCreateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      Icons.lock_outline,
      size: AppDimensions.iconXLarge * 2,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildTitle() {
    return Text(
      'Create Master Password',
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'This password will encrypt all your data',
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

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      label: 'Confirm Password',
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      validator: _validateConfirmPassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: _toggleConfirmPasswordVisibility,
      ),
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
  }

  Widget _buildCreateButton() {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        return CustomButton(
          text: 'Create Password',
          onPressed: _submit,
          isLoading: state is AuthCubitLoading,
        );
      },
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().setupPassword(_passwordController.text);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
