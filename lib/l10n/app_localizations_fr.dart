// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'VaultFlow';

  @override
  String get navHome => 'Accueil';

  @override
  String get navAdd => 'Ajouter';

  @override
  String get navCategories => 'Catégories';

  @override
  String get navStats => 'Statistiques';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get dashboard => 'Tableau de bord';

  @override
  String get transactions => 'Transactions';

  @override
  String get categoriesTitle => 'Catégories';

  @override
  String get statistics => 'Statistiques';

  @override
  String get settings => 'Paramètres';

  @override
  String get noRouteDefined => 'Aucune route définie';

  @override
  String get loading => 'Chargement...';

  @override
  String get loadingSettings => 'Chargement des paramètres...';

  @override
  String get somethingWentWrong => 'Une erreur est survenue';

  @override
  String get retry => 'Réessayer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteAll => 'Tout supprimer';

  @override
  String get add => 'Ajouter';

  @override
  String get save => 'Enregistrer';

  @override
  String get change => 'Modifier';

  @override
  String get clear => 'Effacer';

  @override
  String get logout => 'Déconnexion';

  @override
  String get unlock => 'Déverrouiller';

  @override
  String get createPassword => 'Créer un mot de passe';

  @override
  String get yesReset => 'Oui, réinitialiser';

  @override
  String get expense => 'Dépense';

  @override
  String get expense_plural => 'Dépenses';

  @override
  String get income => 'Revenu';

  @override
  String get income_plural => 'Revenus';

  @override
  String get netBalance => 'Solde net';

  @override
  String get balance => 'Solde';

  @override
  String get totalIncome => 'Revenus totaux';

  @override
  String get totalExpenses => 'Dépenses totales';

  @override
  String summaryFor(String period) {
    return 'Résumé pour $period';
  }

  @override
  String get periodDay => 'Jour';

  @override
  String get periodWeek => 'Semaine';

  @override
  String get periodMonth => 'Mois';

  @override
  String get periodYear => 'Année';

  @override
  String get expenseCategories => 'Catégories de dépenses';

  @override
  String get incomeCategories => 'Catégories de revenus';

  @override
  String get recentTransactions => 'Transactions récentes';

  @override
  String transactionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# transactions',
      one: '# transaction',
      zero: 'Aucune transaction',
    );
    return '$_temp0';
  }

  @override
  String get categoryBreakdown => 'Répartition par catégorie';

  @override
  String get dailyTrends => 'Tendances quotidiennes';

  @override
  String get noCategoryDataAvailable => 'Aucune donnée de catégorie disponible';

  @override
  String get noTrendDataAvailable => 'Aucune donnée de tendance disponible';

  @override
  String get noCategoriesYet => 'Pas encore de catégories';

  @override
  String get noTransactionsYet => 'Pas encore de transactions';

  @override
  String get noCategoriesAvailable => 'Aucune catégorie disponible';

  @override
  String get selectADate => 'Sélectionnez une date';

  @override
  String get welcomeToVaultFlow => 'Bienvenue sur VaultFlow';

  @override
  String get enterYourMasterPassword => 'Entrez votre mot de passe principal';

  @override
  String get createMasterPassword => 'Créer un mot de passe principal';

  @override
  String get passwordWillEncryptData =>
      'Ce mot de passe chiffrera toutes vos données';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get confirmNewPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get passwordMustBeAtLeast6Characters =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get pleaseEnterYourCurrentPassword =>
      'Veuillez entrer votre mot de passe actuel';

  @override
  String get pleaseEnterANewPassword =>
      'Veuillez entrer un nouveau mot de passe';

  @override
  String get pleaseConfirmYourNewPassword =>
      'Veuillez confirmer votre nouveau mot de passe';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordWarning =>
      'Cela supprimera TOUTES vos données, y compris les transactions et les catégories. Vous devrez créer un nouveau mot de passe.\n\nÊtes-vous sûr de vouloir continuer ?';

  @override
  String get addTransaction => 'Ajouter une transaction';

  @override
  String get editTransaction => 'Modifier la transaction';

  @override
  String get deleteTransaction => 'Supprimer la transaction';

  @override
  String confirmDeleteTransaction(String transactionTitle) {
    return 'Êtes-vous sûr de vouloir supprimer \"$transactionTitle\" ?';
  }

  @override
  String get description => 'Description';

  @override
  String get amount => 'Montant';

  @override
  String get category => 'Catégorie';

  @override
  String get date => 'Date';

  @override
  String get type => 'Type';

  @override
  String get icon => 'Icône';

  @override
  String get color => 'Couleur';

  @override
  String get categoryName => 'Nom de la catégorie';

  @override
  String get pleaseEnterADescription => 'Veuillez entrer une description';

  @override
  String get pleaseEnterAnAmount => 'Veuillez entrer un montant';

  @override
  String get pleaseEnterAValidNumber => 'Veuillez entrer un nombre valide';

  @override
  String get pleaseSelectACategory => 'Veuillez sélectionner une catégorie';

  @override
  String get pleaseEnterACategoryName => 'Veuillez entrer un nom de catégorie';

  @override
  String get addCategory => 'Ajouter une catégorie';

  @override
  String get editCategory => 'Modifier la catégorie';

  @override
  String get deleteCategory => 'Supprimer la catégorie';

  @override
  String confirmDeleteCategory(String categoryName) {
    return 'Êtes-vous sûr de vouloir supprimer \"$categoryName\" ?';
  }

  @override
  String get security => 'Sécurité';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get updateYourSecurityPassword =>
      'Mettez à jour votre mot de passe de sécurité';

  @override
  String get dataManagement => 'Gestion des données';

  @override
  String get exportToCSV => 'Exporter en CSV';

  @override
  String get exportYourTransactionsToCSVFile =>
      'Exportez vos transactions vers un fichier CSV';

  @override
  String get exportToPDF => 'Exporter en PDF';

  @override
  String get exportYourTransactionsToPDFFile =>
      'Exportez vos transactions vers un fichier PDF';

  @override
  String get clearOldData => 'Effacer les anciennes données';

  @override
  String get removeTransactionsOlderThanASpecificDate =>
      'Supprimer les transactions antérieures à une date spécifique';

  @override
  String get clearAllData => 'Effacer toutes les données';

  @override
  String get removeAllTransactionsPermanently =>
      'Supprimer toutes les transactions définitivement';

  @override
  String get about => 'À propos';

  @override
  String get appVersion => 'Version de l\'application';

  @override
  String get appNameSetting => 'Nom de l\'application';

  @override
  String get account => 'Compte';

  @override
  String get signOutOfYourAccount => 'Vous déconnecter de votre compte';

  @override
  String get clearOldDataTitle => 'Effacer les anciennes données';

  @override
  String get clearOldDataMessage =>
      'Sélectionnez une date. Toutes les transactions avant cette date seront supprimées.';

  @override
  String get clearAllDataTitle => 'Effacer toutes les données';

  @override
  String get confirmClearAllData =>
      'Êtes-vous sûr de vouloir supprimer TOUTES les transactions ? Cette action ne peut pas être annulée.';

  @override
  String get logoutTitle => 'Déconnexion';

  @override
  String get confirmLogout => 'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get transactionsReport => 'Rapport des transactions';

  @override
  String generated(String date) {
    return 'Généré : $date';
  }

  @override
  String get summary => 'Résumé';

  @override
  String get transactionsExportDate => 'Date';

  @override
  String get transactionsExportType => 'Type';

  @override
  String get transactionsExportCategory => 'Catégorie';

  @override
  String get transactionsExportDescription => 'Description';

  @override
  String get transactionsExportAmount => 'Montant';

  @override
  String get noTransactionsToExport => 'Aucune transaction à exporter';

  @override
  String get loadingAppInfo => 'Chargement...';

  @override
  String get languageSettings => 'Langue';

  @override
  String get appLanguage => 'Langue de l\'application';

  @override
  String get useSystemLanguage => 'Utiliser la langue du système';

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get english => 'Anglais';

  @override
  String get russian => 'Russe';

  @override
  String get ukrainian => 'Ukrainien';

  @override
  String get german => 'Allemand';

  @override
  String get french => 'Français';

  @override
  String get languageChangeSuccess => 'Langue modifiée avec succès';

  @override
  String systemLanguageDetected(String language) {
    return 'Langue du système détectée : $language';
  }

  @override
  String get unsupportedSystemLanguage =>
      'La langue de votre système n\'est pas entièrement prise en charge. L\'anglais est utilisé.';
}
