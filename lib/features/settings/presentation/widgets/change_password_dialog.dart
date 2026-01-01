import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

class ChangePasswordDialog extends StatefulWidget {
  final Function(String oldPassword, String newPassword) onConfirm;

  const ChangePasswordDialog({super.key, required this.onConfirm});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surfaceDark,
      title: _buildTitle(),
      content: _buildContent(),
      actions: _buildActions(context),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Change Password',
      style: TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOldPasswordField(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildNewPasswordField(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildConfirmPasswordField(),
        ],
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      TextButton(onPressed: _handleConfirm, child: const Text('Change')),
    ];
  }

  Widget _buildOldPasswordField() {
    return TextFormField(
      controller: _oldPasswordController,
      obscureText: _obscureOldPassword,
      style: const TextStyle(color: AppColors.categoryTitleText),
      decoration: InputDecoration(
        labelText: 'Current Password',
        labelStyle: const TextStyle(color: AppColors.sectionHeaderText),
        border: _buildOutlineBorder(),
        enabledBorder: _buildOutlineBorder(),
        focusedBorder: _buildFocusedBorder(),
        suffixIcon: _buildVisibilityToggle(
          isObscured: _obscureOldPassword,
          onToggle: () {
            setState(() {
              _obscureOldPassword = !_obscureOldPassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your current password';
        }
        return null;
      },
    );
  }

  Widget _buildVisibilityToggle({
    required bool isObscured,
    required VoidCallback onToggle,
  }) {
    return IconButton(
      icon: Icon(
        isObscured ? Icons.visibility_off : Icons.visibility,
        color: AppColors.sectionHeaderText,
      ),
      onPressed: onToggle,
    );
  }

  Widget _buildNewPasswordField() {
    return TextFormField(
      controller: _newPasswordController,
      obscureText: _obscureNewPassword,
      style: const TextStyle(color: AppColors.categoryTitleText),
      decoration: InputDecoration(
        labelText: 'New Password',
        labelStyle: const TextStyle(color: AppColors.sectionHeaderText),
        border: _buildOutlineBorder(),
        enabledBorder: _buildOutlineBorder(),
        focusedBorder: _buildFocusedBorder(),
        suffixIcon: _buildVisibilityToggle(
          isObscured: _obscureNewPassword,
          onToggle: () {
            setState(() {
              _obscureNewPassword = !_obscureNewPassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a new password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      style: const TextStyle(color: AppColors.categoryTitleText),
      decoration: InputDecoration(
        labelText: 'Confirm New Password',
        labelStyle: const TextStyle(color: AppColors.sectionHeaderText),
        border: _buildOutlineBorder(),
        enabledBorder: _buildOutlineBorder(),
        focusedBorder: _buildFocusedBorder(),
        suffixIcon: _buildVisibilityToggle(
          isObscured: _obscureConfirmPassword,
          onToggle: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your new password';
        }
        if (value != _newPasswordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  OutlineInputBorder _buildOutlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      borderSide: const BorderSide(color: AppColors.sectionHeaderText),
    );
  }

  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      borderSide: const BorderSide(color: AppColors.primary),
    );
  }

  void _handleConfirm() {
    if (_formKey.currentState!.validate()) {
      widget.onConfirm(
        _oldPasswordController.text,
        _newPasswordController.text,
      );
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
