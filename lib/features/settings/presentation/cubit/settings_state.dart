part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final UserSettingsData settings;

  const SettingsLoaded(this.settings);

  @override
  List<Object?> get props => [settings];
}

class SettingsSaveSuccess extends SettingsState {}

class SettingsUpdateSuccess extends SettingsState {}

class SettingsPasswordChangeSuccess extends SettingsState {}

class SettingsExportSuccess extends SettingsState {
  final String filePath;

  const SettingsExportSuccess(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class SettingsClearDataSuccess extends SettingsState {}

class SettingsAppInfoLoaded extends SettingsState {
  final AppInfoData appInfo;

  const SettingsAppInfoLoaded(this.appInfo);

  @override
  List<Object?> get props => [appInfo];
}

class SettingsLogoutSuccess extends SettingsState {}

class SettingsLanguageChanged extends SettingsState {
  final String languageCode;

  const SettingsLanguageChanged(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
