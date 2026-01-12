import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      backgroundColor: AppColors.surfaceDark,
      title: _buildTitle(l10n),
      content: _buildContent(l10n),
      actions: _buildActions(context, l10n),
    );
  }

  Widget _buildTitle(AppLocalizations l10n) {
    return Text(
      l10n.changePassword,
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildContent(AppLocalizations l10n) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOldPasswordField(l10n),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildNewPasswordField(l10n),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildConfirmPasswordField(l10n),
        ],
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context, AppLocalizations l10n) {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(l10n.cancel),
      ),
      TextButton(onPressed: _handleConfirm, child: Text(l10n.change)),
    ];
  }

  Widget _buildOldPasswordField(AppLocalizations l10n) {
    return TextFormField(
      controller: _oldPasswordController,
      obscureText: _obscureOldPassword,
      style: const TextStyle(color: AppColors.categoryTitleText),
      decoration: InputDecoration(
        labelText: l10n.currentPassword,
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
          return l10n.pleaseEnterYourCurrentPassword;
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

  Widget _buildNewPasswordField(AppLocalizations l10n) {
    return TextFormField(
      controller: _newPasswordController,
      obscureText: _obscureNewPassword,
      style: const TextStyle(color: AppColors.categoryTitleText),
      decoration: InputDecoration(
        labelText: l10n.newPassword,
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
          return l10n.pleaseEnterANewPassword;
        }
        if (value.length < 6) {
          return l10n.passwordMustBeAtLeast6Characters;
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField(AppLocalizations l10n) {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      style: const TextStyle(color: AppColors.categoryTitleText),
      decoration: InputDecoration(
        labelText: l10n.confirmNewPassword,
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
          return l10n.pleaseConfirmYourNewPassword;
        }
        if (value != _newPasswordController.text) {
          return l10n.passwordsDoNotMatch;
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
