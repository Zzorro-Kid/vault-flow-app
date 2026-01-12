import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/features/settings/domain/entities/user_settings_data.dart';
import 'package:test_app/features/settings/domain/entities/app_info_data.dart';
import 'package:test_app/features/settings/domain/usecases/get_user_settings.dart';
import 'package:test_app/features/settings/domain/usecases/save_user_settings.dart';
import 'package:test_app/features/settings/domain/usecases/update_currency.dart';
import 'package:test_app/features/settings/domain/usecases/update_report_frequency.dart';
import 'package:test_app/features/settings/domain/usecases/get_app_language.dart';
import 'package:test_app/features/settings/domain/usecases/set_app_language.dart';
import 'package:test_app/features/settings/domain/usecases/get_use_system_language.dart';
import 'package:test_app/features/settings/domain/usecases/set_use_system_language.dart';
import 'package:test_app/features/settings/domain/usecases/change_password.dart';
import 'package:test_app/features/settings/domain/usecases/export_data_to_csv.dart';
import 'package:test_app/features/settings/domain/usecases/export_data_to_pdf.dart';
import 'package:test_app/features/settings/domain/usecases/clear_old_data.dart';
import 'package:test_app/features/settings/domain/usecases/clear_all_data.dart';
import 'package:test_app/features/settings/domain/usecases/get_app_info.dart';
import 'package:test_app/features/settings/domain/usecases/logout.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetUserSettings getUserSettings;
  final SaveUserSettings saveUserSettings;
  final UpdateCurrency updateCurrency;
  final UpdateReportFrequency updateReportFrequency;
  final GetAppLanguage getAppLanguage;
  final SetAppLanguage setAppLanguage;
  final GetUseSystemLanguage getUseSystemLanguage;
  final SetUseSystemLanguage setUseSystemLanguage;
  final ChangePassword changePassword;
  final ExportDataToCSV exportDataToCSV;
  final ExportDataToPDF exportDataToPDF;
  final ClearOldData clearOldData;
  final ClearAllData clearAllData;
  final GetAppInfo getAppInfo;
  final Logout logout;

  SettingsCubit({
    required this.getUserSettings,
    required this.saveUserSettings,
    required this.updateCurrency,
    required this.updateReportFrequency,
    required this.getAppLanguage,
    required this.setAppLanguage,
    required this.getUseSystemLanguage,
    required this.setUseSystemLanguage,
    required this.changePassword,
    required this.exportDataToCSV,
    required this.exportDataToPDF,
    required this.clearOldData,
    required this.clearAllData,
    required this.getAppInfo,
    required this.logout,
  }) : super(SettingsInitial());

  Future<void> loadUserSettings(String userId) async {
    emit(SettingsLoading());

    final result = await getUserSettings(userId);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> saveSettings(UserSettingsData settings) async {
    emit(SettingsLoading());

    final result = await saveUserSettings(settings);

    result.fold((failure) => emit(SettingsError(failure.message)), (_) async {
      await loadUserSettings(settings.userId);
      emit(SettingsSaveSuccess());
    });
  }

  Future<void> updateUserCurrency(String userId, String currency) async {
    emit(SettingsLoading());

    final result = await updateCurrency(userId: userId, currency: currency);

    result.fold((failure) => emit(SettingsError(failure.message)), (_) async {
      await loadUserSettings(userId);
      emit(SettingsUpdateSuccess());
    });
  }

  Future<void> updateUserReportFrequency(
    String userId,
    String frequency,
  ) async {
    emit(SettingsLoading());

    final result = await updateReportFrequency(
      userId: userId,
      frequency: frequency,
    );

    result.fold((failure) => emit(SettingsError(failure.message)), (_) async {
      await loadUserSettings(userId);
      emit(SettingsUpdateSuccess());
    });
  }

  Future<void> updatePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(SettingsLoading());

    final result = await changePassword(
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => emit(SettingsPasswordChangeSuccess()),
    );
  }

  Future<void> exportToCSV(String userId) async {
    emit(SettingsLoading());

    final result = await exportDataToCSV(userId);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (filePath) => emit(SettingsExportSuccess(filePath)),
    );
  }

  Future<void> exportToPDF(String userId) async {
    emit(SettingsLoading());

    final result = await exportDataToPDF(userId);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (filePath) => emit(SettingsExportSuccess(filePath)),
    );
  }

  Future<void> clearDataBeforeDate(String userId, DateTime beforeDate) async {
    emit(SettingsLoading());

    final result = await clearOldData(userId: userId, beforeDate: beforeDate);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => emit(SettingsClearDataSuccess()),
    );
  }

  Future<void> clearAll() async {
    emit(SettingsLoading());

    final result = await clearAllData();

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => emit(SettingsClearDataSuccess()),
    );
  }

  Future<void> loadAppInfo() async {
    emit(SettingsLoading());

    final result = await getAppInfo();

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (appInfo) => emit(SettingsAppInfoLoaded(appInfo)),
    );
  }

  Future<void> performLogout() async {
    emit(SettingsLoading());

    final result = await logout();

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => emit(SettingsLogoutSuccess()),
    );
  }

  Future<void> loadLanguageSettings(String userId) async {
    emit(SettingsLoading());

    final result = await getUserSettings(userId);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> changeAppLanguage(String userId, String languageCode) async {
    await loadUserSettings(userId);
    final result = await setAppLanguage(userId, languageCode);
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => emit(SettingsLanguageChanged(languageCode)),
    );
  }

  Future<void> toggleSystemLanguage(String userId, bool useSystem) async {
    emit(SettingsLoading());

    final result = await setUseSystemLanguage(userId, useSystem);

    result.fold((failure) => emit(SettingsError(failure.message)), (_) async {
      await loadUserSettings(userId);
      emit(SettingsUpdateSuccess());
    });
  }
}
