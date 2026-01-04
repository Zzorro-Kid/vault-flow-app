import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/widgets/bottom_navigation_bar.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:test_app/features/settings/presentation/widgets/settings_section.dart';
import 'package:test_app/features/settings/presentation/widgets/settings_tile.dart';
import 'package:test_app/features/settings/presentation/widgets/change_password_dialog.dart';
import 'package:test_app/features/settings/presentation/widgets/clear_data_dialog.dart';
import 'package:test_app/injection_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingsCubit>()..loadAppInfo(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 4),
      ),
    );
  }

  void _navigateToAuth(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/auth', (route) => false);
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(title: _buildAppBarTitle());
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Settings',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeXXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.categoryTitleText,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const LoadingIndicator(message: 'Loading settings...');
        }

        return ListView(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          children: [
            _buildSecuritySection(context),
            const SizedBox(height: AppDimensions.paddingLarge),
            _buildDataSection(context),
            const SizedBox(height: AppDimensions.paddingLarge),
            _buildAboutSection(context),
            const SizedBox(height: AppDimensions.paddingLarge),
            _buildAccountSection(context),
          ],
        );
      },
    );
  }

  Widget _buildSecuritySection(BuildContext context) {
    return SettingsSection(
      title: 'Security',
      children: [
        SettingsTile(
          icon: Icons.lock_outline,
          title: 'Change Password',
          subtitle: 'Update your security password',
          onTap: () => _showChangePasswordDialog(context),
        ),
      ],
    );
  }

  Widget _buildDataSection(BuildContext context) {
    return SettingsSection(
      title: 'Data Management',
      children: [
        _buildExportToCSVTile(context),
        _buildExportToPDFTile(context),
        _buildClearOldDataTile(context),
        _buildClearAllDataTile(context),
      ],
    );
  }

  Widget _buildExportToCSVTile(BuildContext context) {
    return SettingsTile(
      icon: Icons.file_download_outlined,
      title: 'Export to CSV',
      subtitle: 'Export your transactions to CSV file',
      onTap: () => _exportToCSV(context),
    );
  }

  Widget _buildExportToPDFTile(BuildContext context) {
    return SettingsTile(
      icon: Icons.picture_as_pdf_outlined,
      title: 'Export to PDF',
      subtitle: 'Export your transactions to PDF file',
      onTap: () => _exportToPDF(context),
    );
  }

  Widget _buildClearOldDataTile(BuildContext context) {
    return SettingsTile(
      icon: Icons.delete_sweep_outlined,
      title: 'Clear Old Data',
      subtitle: 'Remove transactions older than a specific date',
      onTap: () => _showClearOldDataDialog(context),
    );
  }

  Widget _buildClearAllDataTile(BuildContext context) {
    return SettingsTile(
      icon: Icons.delete_forever_outlined,
      title: 'Clear All Data',
      subtitle: 'Remove all transactions permanently',
      onTap: () => _showClearAllDataDialog(context),
      isDestructive: true,
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final appInfo = state is SettingsAppInfoLoaded ? state.appInfo : null;

        return SettingsSection(
          title: 'About',
          children: [_buildAppVersionTile(appInfo), _buildAppNameTile(appInfo)],
        );
      },
    );
  }

  Widget _buildAppVersionTile(dynamic appInfo) {
    return SettingsTile(
      icon: Icons.info_outline,
      title: 'App Version',
      subtitle: appInfo != null
          ? '${appInfo.version} (${appInfo.buildNumber})'
          : 'Loading...',
      trailing: const SizedBox.shrink(),
    );
  }

  Widget _buildAppNameTile(dynamic appInfo) {
    return SettingsTile(
      icon: Icons.apps_outlined,
      title: 'App Name',
      subtitle: appInfo?.appName ?? 'Loading...',
      trailing: const SizedBox.shrink(),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return SettingsSection(
      title: 'Account',
      children: [
        SettingsTile(
          icon: Icons.logout_outlined,
          title: 'Logout',
          subtitle: 'Sign out of your account',
          onTap: () => _showLogoutDialog(context),
          isDestructive: true,
        ),
      ],
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => ChangePasswordDialog(
        onConfirm: (oldPassword, newPassword) {
          context.read<SettingsCubit>().updatePassword(
            userId: 'user_id',
            oldPassword: oldPassword,
            newPassword: newPassword,
          );
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  void _exportToCSV(BuildContext context) {
    context.read<SettingsCubit>().exportToCSV('user_id');
  }

  void _exportToPDF(BuildContext context) {
    context.read<SettingsCubit>().exportToPDF('user_id');
  }

  void _showClearOldDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => ClearDataDialog(
        title: 'Clear Old Data',
        message:
            'Select a date. All transactions before this date will be deleted.',
        onConfirm: (date) {
          context.read<SettingsCubit>().clearDataBeforeDate('user_id', date);
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  void _showClearAllDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: _buildClearAllDataTitle(),
        content: _buildClearAllDataContent(),
        actions: _buildClearAllDataActions(dialogContext, context),
      ),
    );
  }

  Widget _buildClearAllDataTitle() {
    return const Text(
      'Clear All Data',
      style: TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildClearAllDataContent() {
    return const Text(
      'Are you sure you want to delete ALL transactions? This action cannot be undone.',
      style: TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildClearAllDataActions(
    BuildContext dialogContext,
    BuildContext parentContext,
  ) {
    return [
      _buildCancelButton(dialogContext),
      _buildDeleteAllButton(dialogContext, parentContext),
    ];
  }

  Widget _buildCancelButton(BuildContext dialogContext) {
    return TextButton(
      onPressed: () => Navigator.pop(dialogContext),
      child: const Text('Cancel'),
    );
  }

  Widget _buildDeleteAllButton(
    BuildContext dialogContext,
    BuildContext parentContext,
  ) {
    return TextButton(
      onPressed: () {
        parentContext.read<SettingsCubit>().clearAll();
        Navigator.pop(dialogContext);
      },
      child: const Text('Delete All', style: TextStyle(color: AppColors.error)),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: _buildLogoutTitle(),
        content: _buildLogoutContent(),
        actions: _buildLogoutActions(dialogContext, context),
      ),
    );
  }

  Widget _buildLogoutTitle() {
    return const Text(
      'Logout',
      style: TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildLogoutContent() {
    return const Text(
      'Are you sure you want to logout?',
      style: TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildLogoutActions(
    BuildContext dialogContext,
    BuildContext parentContext,
  ) {
    return [
      _buildCancelButton(dialogContext),
      _buildLogoutButton(dialogContext, parentContext),
    ];
  }

  Widget _buildLogoutButton(
    BuildContext dialogContext,
    BuildContext parentContext,
  ) {
    return TextButton(
      onPressed: () {
        parentContext.read<SettingsCubit>().performLogout();
        Navigator.pop(dialogContext);
        _navigateToAuth(parentContext);
      },
      child: const Text('Logout', style: TextStyle(color: AppColors.error)),
    );
  }
}
