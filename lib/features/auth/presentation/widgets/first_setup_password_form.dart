import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/utils/validators.dart';
import 'package:test_app/core/widgets/custom_button.dart';
import 'package:test_app/core/widgets/custom_text_field.dart';
import 'package:test_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:test_app/l10n/app_localizations.dart';

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
    return SingleChildScrollView(
      child: Padding(
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
      AppLocalizations.of(context)!.createMasterPassword,
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      AppLocalizations.of(context)!.passwordWillEncryptData,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      label: AppLocalizations.of(context)!.password,
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

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      label: AppLocalizations.of(context)!.confirmPassword,
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      validator: _validateConfirmPassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
        },
      ),
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return AppLocalizations.of(context)!.passwordsDoNotMatch;
    }
    return null;
  }

  Widget _buildCreateButton() {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        return CustomButton(
          text: AppLocalizations.of(context)!.createPassword,
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
