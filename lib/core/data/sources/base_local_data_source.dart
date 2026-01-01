import 'package:test_app/features/transaction/data/models/financial_summary_data_model.dart';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/core/errors/exceptions.dart';
import 'package:test_app/core/services/storage_service.dart';
import 'package:test_app/core/services/auth_service.dart';
import 'package:test_app/core/services/export_service.dart';
import 'package:test_app/core/services/financial_service.dart';
import 'package:test_app/core/enums/period_type.dart';

abstract class BaseLocalDataSource {
  final StorageService storageService;
  final AuthService authService;
  final ExportService exportService;
  final FinancialService financialService;

  BaseLocalDataSource({
    required this.storageService,
    required this.authService,
    required this.exportService,
    required this.financialService,
  });

  Future<T> executeDataSourceCall<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Operation failed';
      throw CacheException('$message: $e');
    }
  }

  Future<void> executeStorageWrite(
    Future<void> Function() call, {
    String? errorMessage,
  }) async {
    try {
      await call();
    } catch (e) {
      final message = errorMessage ?? 'Storage write failed';
      throw StorageException('$message: $e');
    }
  }

  Future<T> executeStorageRead<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Storage read failed';
      throw CacheException('$message: $e');
    }
  }

  Future<T> executeAuthOperation<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Authentication operation failed';
      throw AuthenticationException('$message: $e');
    }
  }

  Future<T> executeEncryptionOperation<T>(
    Future<T> Function() call, {
    String? errorMessage,
  }) async {
    try {
      return await call();
    } catch (e) {
      final message = errorMessage ?? 'Encryption operation failed';
      throw EncryptionException('$message: $e');
    }
  }

  Future<List<TransactionDataModel>> loadTransactionsFromStorage() async {
    return await storageService.loadTransactions();
  }

  Future<void> saveTransactions(List<TransactionDataModel> transactions) async {
    await storageService.saveTransactions(transactions);
  }

  Future<List<CategoryDataModel>> loadCategoriesFromStorage() async {
    return await storageService.loadCategories();
  }

  Future<void> saveCategories(List<CategoryDataModel> categories) async {
    await storageService.saveCategories(categories);
  }

  Future<T?> loadModelFromStorage<T>({
    required String userId,
    required Future<String?> Function(String userId) getter,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    return await storageService.loadModel<T>(
      userId: userId,
      getter: getter,
      fromJson: fromJson,
    );
  }

  Future<void> saveModelToStorage<T>({
    required String userId,
    required T model,
    required Future<void> Function(String userId, String json) setter,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    await storageService.saveModel<T>(
      userId: userId,
      model: model,
      setter: setter,
      toJson: toJson,
    );
  }

  Future<void> updateModelField<T>({
    required String userId,
    required Future<T> Function(String userId) getter,
    required Future<void> Function(T model) saver,
    required T Function(T model) updater,
  }) async {
    await storageService.updateModelField<T>(
      userId: userId,
      getter: getter,
      saver: saver,
      updater: updater,
    );
  }

  Future<void> clearAllStorage() async {
    await storageService.clearAll();
  }

  String hashPassword(String password) {
    return authService.hashPassword(password);
  }

  Future<bool> verifyPasswordHash(String password, String storedHash) async {
    return await authService.verifyPasswordHash(password, storedHash);
  }

  Future<void> changePasswordWithVerification({
    required String oldPassword,
    required String newPassword,
    required Future<String?> Function() getStoredHash,
    required Future<void> Function(String hash) setNewHash,
  }) async {
    await authService.changePasswordWithVerification(
      oldPassword: oldPassword,
      newPassword: newPassword,
      getStoredHash: getStoredHash,
      setNewHash: setNewHash,
    );
  }

  Future<String> exportTransactionsToCSV({
    required List<TransactionDataModel> transactions,
    required String filePrefix,
  }) async {
    return await exportService.exportTransactionsToCSV(
      transactions: transactions,
      filePrefix: filePrefix,
    );
  }

  Future<String> exportTransactionsToPDF({
    required List<TransactionDataModel> transactions,
    required String filePrefix,
  }) async {
    return await exportService.exportTransactionsToPDF(
      transactions: transactions,
      filePrefix: filePrefix,
    );
  }

  FinancialSummaryDataModel calculateFinancialSummary(
    List<TransactionDataModel> transactions,
  ) {
    return financialService.calculateFinancialSummary(transactions);
  }

  List<TransactionDataModel> filterTransactionsByPeriod(
    List<TransactionDataModel> transactions,
    PeriodType period,
  ) {
    return financialService.filterTransactionsByPeriod(transactions, period);
  }
}
