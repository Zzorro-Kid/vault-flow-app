// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'VaultFlow';

  @override
  String get navHome => 'Startseite';

  @override
  String get navAdd => 'Hinzufügen';

  @override
  String get navCategories => 'Kategorien';

  @override
  String get navStats => 'Statistik';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get transactions => 'Transaktionen';

  @override
  String get categoriesTitle => 'Kategorien';

  @override
  String get statistics => 'Statistik';

  @override
  String get settings => 'Einstellungen';

  @override
  String get noRouteDefined => 'Keine Route definiert';

  @override
  String get loading => 'Laden...';

  @override
  String get loadingSettings => 'Einstellungen werden geladen...';

  @override
  String get somethingWentWrong => 'Etwas ist schiefgelaufen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteAll => 'Alle löschen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get save => 'Speichern';

  @override
  String get change => 'Ändern';

  @override
  String get clear => 'Löschen';

  @override
  String get logout => 'Abmelden';

  @override
  String get unlock => 'Entsperren';

  @override
  String get createPassword => 'Passwort erstellen';

  @override
  String get yesReset => 'Ja, zurücksetzen';

  @override
  String get expense => 'Ausgabe';

  @override
  String get expense_plural => 'Ausgaben';

  @override
  String get income => 'Einnahme';

  @override
  String get income_plural => 'Einnahmen';

  @override
  String get netBalance => 'Nettoguthaben';

  @override
  String get balance => 'Guthaben';

  @override
  String get totalIncome => 'Gesamteinnahmen';

  @override
  String get totalExpenses => 'Gesamtausgaben';

  @override
  String summaryFor(String period) {
    return 'Zusammenfassung für $period';
  }

  @override
  String get periodDay => 'Tag';

  @override
  String get periodWeek => 'Woche';

  @override
  String get periodMonth => 'Monat';

  @override
  String get periodYear => 'Jahr';

  @override
  String get expenseCategories => 'Ausgabenkategorien';

  @override
  String get incomeCategories => 'Einnahmekategorien';

  @override
  String get recentTransactions => 'Letzte Transaktionen';

  @override
  String transactionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# Transaktionen',
      one: '# Transaktion',
      zero: 'Keine Transaktionen',
    );
    return '$_temp0';
  }

  @override
  String get categoryBreakdown => 'Kategorienaufschlüsselung';

  @override
  String get dailyTrends => 'Tägliche Trends';

  @override
  String get noCategoryDataAvailable => 'Keine Kategoriedaten verfügbar';

  @override
  String get noTrendDataAvailable => 'Keine Trenddaten verfügbar';

  @override
  String get noCategoriesYet => 'Noch keine Kategorien';

  @override
  String get noTransactionsYet => 'Noch keine Transaktionen';

  @override
  String get noCategoriesAvailable => 'Keine Kategorien verfügbar';

  @override
  String get selectADate => 'Datum auswählen';

  @override
  String get welcomeToVaultFlow => 'Willkommen bei VaultFlow';

  @override
  String get enterYourMasterPassword => 'Geben Sie Ihr Master-Passwort ein';

  @override
  String get createMasterPassword => 'Master-Passwort erstellen';

  @override
  String get passwordWillEncryptData =>
      'Dieses Passwort verschlüsselt alle Ihre Daten';

  @override
  String get password => 'Passwort';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get currentPassword => 'Aktuelles Passwort';

  @override
  String get newPassword => 'Neues Passwort';

  @override
  String get confirmNewPassword => 'Neues Passwort bestätigen';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get passwordMustBeAtLeast6Characters =>
      'Das Passwort muss mindestens 6 Zeichen lang sein';

  @override
  String get pleaseEnterYourCurrentPassword =>
      'Bitte geben Sie Ihr aktuelles Passwort ein';

  @override
  String get pleaseEnterANewPassword =>
      'Bitte geben Sie ein neues Passwort ein';

  @override
  String get pleaseConfirmYourNewPassword =>
      'Bitte bestätigen Sie Ihr neues Passwort';

  @override
  String get resetPassword => 'Passwort zurücksetzen';

  @override
  String get resetPasswordWarning =>
      'Dies löscht ALLE Ihre Daten, einschließlich Transaktionen und Kategorien. Sie müssen ein neues Passwort erstellen.\n\nSind Sie sicher, dass Sie fortfahren möchten?';

  @override
  String get addTransaction => 'Transaktion hinzufügen';

  @override
  String get editTransaction => 'Transaktion bearbeiten';

  @override
  String get deleteTransaction => 'Transaktion löschen';

  @override
  String confirmDeleteTransaction(String transactionTitle) {
    return 'Sind Sie sicher, dass Sie \"$transactionTitle\" löschen möchten?';
  }

  @override
  String get description => 'Beschreibung';

  @override
  String get amount => 'Betrag';

  @override
  String get category => 'Kategorie';

  @override
  String get date => 'Datum';

  @override
  String get type => 'Typ';

  @override
  String get icon => 'Symbol';

  @override
  String get color => 'Farbe';

  @override
  String get categoryName => 'Kategoriename';

  @override
  String get pleaseEnterADescription => 'Bitte geben Sie eine Beschreibung ein';

  @override
  String get pleaseEnterAnAmount => 'Bitte geben Sie einen Betrag ein';

  @override
  String get pleaseEnterAValidNumber => 'Bitte geben Sie eine gültige Zahl ein';

  @override
  String get pleaseSelectACategory => 'Bitte wählen Sie eine Kategorie';

  @override
  String get pleaseEnterACategoryName =>
      'Bitte geben Sie einen Kategorienamen ein';

  @override
  String get addCategory => 'Kategorie hinzufügen';

  @override
  String get editCategory => 'Kategorie bearbeiten';

  @override
  String get deleteCategory => 'Kategorie löschen';

  @override
  String confirmDeleteCategory(String categoryName) {
    return 'Sind Sie sicher, dass Sie \"$categoryName\" löschen möchten?';
  }

  @override
  String get security => 'Sicherheit';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get updateYourSecurityPassword =>
      'Aktualisieren Sie Ihr Sicherheitspasswort';

  @override
  String get dataManagement => 'Datenverwaltung';

  @override
  String get exportToCSV => 'Als CSV exportieren';

  @override
  String get exportYourTransactionsToCSVFile =>
      'Exportieren Sie Ihre Transaktionen als CSV-Datei';

  @override
  String get exportToPDF => 'Als PDF exportieren';

  @override
  String get exportYourTransactionsToPDFFile =>
      'Exportieren Sie Ihre Transaktionen als PDF-Datei';

  @override
  String get clearOldData => 'Alte Daten löschen';

  @override
  String get removeTransactionsOlderThanASpecificDate =>
      'Transaktionen vor einem bestimmten Datum entfernen';

  @override
  String get clearAllData => 'Alle Daten löschen';

  @override
  String get removeAllTransactionsPermanently =>
      'Alle Transaktionen dauerhaft entfernen';

  @override
  String get about => 'Über';

  @override
  String get appVersion => 'App-Version';

  @override
  String get appNameSetting => 'App-Name';

  @override
  String get account => 'Konto';

  @override
  String get signOutOfYourAccount => 'Von Ihrem Konto abmelden';

  @override
  String get clearOldDataTitle => 'Alte Daten löschen';

  @override
  String get clearOldDataMessage =>
      'Wählen Sie ein Datum. Alle Transaktionen vor diesem Datum werden gelöscht.';

  @override
  String get clearAllDataTitle => 'Alle Daten löschen';

  @override
  String get confirmClearAllData =>
      'Sind Sie sicher, dass Sie ALLE Transaktionen löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get logoutTitle => 'Abmelden';

  @override
  String get confirmLogout =>
      'Sind Sie sicher, dass Sie sich abmelden möchten?';

  @override
  String get transactionsReport => 'Transaktionsbericht';

  @override
  String generated(String date) {
    return 'Erstellt: $date';
  }

  @override
  String get summary => 'Zusammenfassung';

  @override
  String get transactionsExportDate => 'Datum';

  @override
  String get transactionsExportType => 'Typ';

  @override
  String get transactionsExportCategory => 'Kategorie';

  @override
  String get transactionsExportDescription => 'Beschreibung';

  @override
  String get transactionsExportAmount => 'Betrag';

  @override
  String get noTransactionsToExport => 'Keine Transaktionen zum Exportieren';

  @override
  String get loadingAppInfo => 'Laden...';
}
