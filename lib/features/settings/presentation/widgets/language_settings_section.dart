import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/services/locale_service.dart';
import 'package:test_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:test_app/features/settings/presentation/widgets/settings_section.dart';
import 'package:test_app/features/settings/presentation/widgets/settings_tile.dart';
import 'package:test_app/l10n/app_localizations.dart';

class LanguageSettingsSection extends StatelessWidget {
  const LanguageSettingsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is! SettingsLoaded) {
          return const SizedBox.shrink();
        }
        final settings = state.settings;
        final currentLanguageName =
            LocaleService.languageNames[settings.appLanguage] ??
            settings.appLanguage;
        return SettingsSection(
          title: l10n.languageSettings,
          children: [
            _buildLanguageSelector(context, l10n, currentLanguageName),
          ],
        );
      },
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    AppLocalizations l10n,
    String currentLanguageName,
  ) {
    return SettingsTile(
      icon: Icons.language_outlined,
      title: l10n.appLanguage,
      subtitle: currentLanguageName,
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.sectionHeaderText,
      ),
      onTap: () => _showLanguagePickerDialog(context),
    );
  }

  void _showLanguagePickerDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<SettingsCubit>();
    final currentState = cubit.state;
    final currentLanguage = currentState is SettingsLoaded
        ? currentState.settings.appLanguage
        : 'en';
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text(
          l10n.selectLanguage,
          style: const TextStyle(color: AppColors.categoryTitleText),
        ),
        content: _buildLanguageList(currentLanguage, cubit, dialogContext),
      ),
    );
  }

  Widget _buildLanguageList(
    String currentLanguage,
    SettingsCubit cubit,
    BuildContext dialogContext,
  ) {
    return SizedBox(
      width: double.maxFinite,
      height: 300,
      child: ListView.builder(
        itemCount: LocaleService.languageNames.length,
        itemBuilder: (context, index) {
          final entry = LocaleService.languageNames.entries.elementAt(index);
          final languageCode = entry.key;
          final languageName = entry.value;
          final isSelected = languageCode == currentLanguage;
          return _buildLanguageTile(
            languageCode,
            languageName,
            isSelected,
            cubit,
            dialogContext,
          );
        },
      ),
    );
  }

  Widget _buildLanguageTile(
    String languageCode,
    String languageName,
    bool isSelected,
    SettingsCubit cubit,
    BuildContext dialogContext,
  ) {
    return InkWell(
      onTap: () {
        cubit.changeAppLanguage('user_id', languageCode);
        Navigator.pop(dialogContext);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                languageName,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeMedium,
                  color: AppColors.categoryTitleText,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
