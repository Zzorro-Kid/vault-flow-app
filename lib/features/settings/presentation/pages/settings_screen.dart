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
import 'package:test_app/features/settings/presentation/widgets/language_settings_section.dart';
import 'package:test_app/injection_container.dart';
import 'package:test_app/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingsCubit>()
        ..loadUserSettings('user_id')
        ..loadAppInfo(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 4),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(title: _buildAppBarTitle());
  }

  Widget _buildAppBarTitle() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return Text(
          l10n.settings,
          style: const TextStyle(
            fontSize: AppDimensions.fontSizeXXLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.categoryTitleText,
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const LoadingIndicator(message: 'Loading settings...');
        }

        return Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return ListView(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              children: [
                const LanguageSettingsSection(),
                const SizedBox(height: AppDimensions.paddingLarge),
                _buildSecuritySection(context, l10n),
                const SizedBox(height: AppDimensions.paddingLarge),
                _buildDataSection(context, l10n),
                const SizedBox(height: AppDimensions.paddingLarge),
                _buildAboutSection(context, l10n),
                const SizedBox(height: AppDimensions.paddingLarge),
                _buildAccountSection(context, l10n),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSecuritySection(BuildContext context, AppLocalizations l10n) {
    return SettingsSection(
      title: l10n.security,
      children: [
        SettingsTile(
          icon: Icons.lock_outline,
          title: l10n.changePassword,
          subtitle: l10n.updateYourSecurityPassword,
          onTap: () => _showChangePasswordDialog(context),
        ),
      ],
    );
  }

  Widget _buildDataSection(BuildContext context, AppLocalizations l10n) {
    return SettingsSection(
      title: l10n.dataManagement,
      children: [
        _buildExportToCSVTile(context, l10n),
        _buildExportToPDFTile(context, l10n),
        _buildClearOldDataTile(context, l10n),
        _buildClearAllDataTile(context, l10n),
      ],
    );
  }

  Widget _buildExportToCSVTile(BuildContext context, AppLocalizations l10n) {
    return SettingsTile(
      icon: Icons.file_download_outlined,
      title: l10n.exportToCSV,
      subtitle: l10n.exportYourTransactionsToCSVFile,
      onTap: () => _exportToCSV(context),
    );
  }

  Widget _buildExportToPDFTile(BuildContext context, AppLocalizations l10n) {
    return SettingsTile(
      icon: Icons.picture_as_pdf_outlined,
      title: l10n.exportToPDF,
      subtitle: l10n.exportYourTransactionsToPDFFile,
      onTap: () => _exportToPDF(context),
    );
  }

  Widget _buildClearOldDataTile(BuildContext context, AppLocalizations l10n) {
    return SettingsTile(
      icon: Icons.delete_sweep_outlined,
      title: l10n.clearOldData,
      subtitle: l10n.removeTransactionsOlderThanASpecificDate,
      onTap: () => _showClearOldDataDialog(context, l10n),
    );
  }

  Widget _buildClearAllDataTile(BuildContext context, AppLocalizations l10n) {
    return SettingsTile(
      icon: Icons.delete_forever_outlined,
      title: l10n.clearAllData,
      subtitle: l10n.removeAllTransactionsPermanently,
      onTap: () => _showClearAllDataDialog(context, l10n),
      isDestructive: true,
    );
  }

  Widget _buildAboutSection(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final appInfo = state is SettingsAppInfoLoaded ? state.appInfo : null;

        return SettingsSection(
          title: l10n.about,
          children: [
            _buildAppVersionTile(appInfo, l10n),
            _buildAppNameTile(appInfo, l10n),
          ],
        );
      },
    );
  }

  Widget _buildAppVersionTile(dynamic appInfo, AppLocalizations l10n) {
    return SettingsTile(
      icon: Icons.info_outline,
      title: l10n.appVersion,
      subtitle: appInfo != null
          ? '${appInfo.version} (${appInfo.buildNumber})'
          : l10n.loadingAppInfo,
      trailing: const SizedBox.shrink(),
    );
  }

  Widget _buildAppNameTile(dynamic appInfo, AppLocalizations l10n) {
    return SettingsTile(
      icon: Icons.apps_outlined,
      title: l10n.appNameSetting,
      subtitle: appInfo?.appName ?? l10n.loadingAppInfo,
      trailing: const SizedBox.shrink(),
    );
  }

  Widget _buildAccountSection(BuildContext context, AppLocalizations l10n) {
    return SettingsSection(
      title: l10n.account,
      children: [
        SettingsTile(
          icon: Icons.logout_outlined,
          title: l10n.logout,
          subtitle: l10n.signOutOfYourAccount,
          onTap: () => _showLogoutDialog(context, l10n),
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

  void _showClearOldDataDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => ClearDataDialog(
        title: l10n.clearOldDataTitle,
        message: l10n.clearOldDataMessage,
        onConfirm: (date) {
          context.read<SettingsCubit>().clearDataBeforeDate('user_id', date);
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  void _showClearAllDataDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: _buildClearAllDataTitle(l10n),
        content: _buildClearAllDataContent(l10n),
        actions: _buildClearAllDataActions(dialogContext, context, l10n),
      ),
    );
  }

  Widget _buildClearAllDataTitle(AppLocalizations l10n) {
    return Text(
      l10n.clearAllDataTitle,
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildClearAllDataContent(AppLocalizations l10n) {
    return Text(
      l10n.confirmClearAllData,
      style: const TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildClearAllDataActions(
    BuildContext dialogContext,
    BuildContext parentContext,
    AppLocalizations l10n,
  ) {
    return [
      _buildCancelButton(dialogContext, l10n),
      _buildDeleteAllButton(dialogContext, parentContext, l10n),
    ];
  }

  Widget _buildCancelButton(BuildContext dialogContext, AppLocalizations l10n) {
    return TextButton(
      onPressed: () => Navigator.pop(dialogContext),
      child: Text(l10n.cancel),
    );
  }

  Widget _buildDeleteAllButton(
    BuildContext dialogContext,
    BuildContext parentContext,
    AppLocalizations l10n,
  ) {
    return TextButton(
      onPressed: () {
        parentContext.read<SettingsCubit>().clearAll();
        Navigator.pop(dialogContext);
      },
      child: Text(
        l10n.deleteAll,
        style: const TextStyle(color: AppColors.error),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: _buildLogoutTitle(l10n),
        content: _buildLogoutContent(l10n),
        actions: _buildLogoutActions(dialogContext, context, l10n),
      ),
    );
  }

  Widget _buildLogoutTitle(AppLocalizations l10n) {
    return Text(
      l10n.logoutTitle,
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildLogoutContent(AppLocalizations l10n) {
    return Text(
      l10n.confirmLogout,
      style: const TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildLogoutActions(
    BuildContext dialogContext,
    BuildContext parentContext,
    AppLocalizations l10n,
  ) {
    return [
      _buildCancelButton(dialogContext, l10n),
      _buildLogoutButton(dialogContext, parentContext, l10n),
    ];
  }

  Widget _buildLogoutButton(
    BuildContext dialogContext,
    BuildContext parentContext,
    AppLocalizations l10n,
  ) {
    return TextButton(
      onPressed: () {
        parentContext.read<SettingsCubit>().performLogout();
        Navigator.pop(dialogContext);
        _navigateToAuth(parentContext);
      },
      child: Text(l10n.logout, style: const TextStyle(color: AppColors.error)),
    );
  }

  void _navigateToAuth(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/auth', (route) => false);
  }
}
