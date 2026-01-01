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
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surfaceDark,
      title: const Text(
        'Change Password',
        style: TextStyle(color: AppColors.categoryTitleText),
      ),
      content: Form(
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
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _handleConfirm, child: const Text('Change')),
      ],
    );
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
        suffixIcon: IconButton(
          icon: Icon(
            _obscureOldPassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.sectionHeaderText,
          ),
          onPressed: () {
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
        suffixIcon: IconButton(
          icon: Icon(
            _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.sectionHeaderText,
          ),
          onPressed: () {
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
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.sectionHeaderText,
          ),
          onPressed: () {
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
}
