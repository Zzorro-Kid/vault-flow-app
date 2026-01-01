import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:test_app/features/transaction/data/models/financial_summary_data_model.dart';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/core/errors/exceptions.dart';
import 'package:test_app/core/secure_prefs.dart';

abstract class BaseLocalDataSource {
  SecurePrefs? get securePrefs => null;
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
    if (securePrefs == null) {
      throw Exception('SecurePrefs is not initialized');
    }

    final transactionsJson = await securePrefs!.transactions;

    if (transactionsJson == null || transactionsJson.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList =
        json.decode(transactionsJson) as List<dynamic>;

    return jsonList
        .map(
          (json) => TransactionDataModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> saveTransactions(List<TransactionDataModel> transactions) async {
    if (securePrefs == null) {
      throw Exception('SecurePrefs is not initialized');
    }

    final jsonList = transactions.map((t) => t.toJson()).toList();
    final transactionsJson = json.encode(jsonList);
    await securePrefs!.setTransactions(transactionsJson);
  }

  Future<List<CategoryDataModel>> loadCategoriesFromStorage() async {
    if (securePrefs == null) {
      throw Exception('SecurePrefs is not initialized');
    }

    final categoriesJson = await securePrefs!.categories;

    if (categoriesJson == null || categoriesJson.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = json.decode(categoriesJson) as List<dynamic>;

    return jsonList
        .map((json) => CategoryDataModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveCategories(List<CategoryDataModel> categories) async {
    if (securePrefs == null) {
      throw Exception('SecurePrefs is not initialized');
    }

    final jsonList = categories.map((c) => c.toJson()).toList();
    final categoriesJson = json.encode(jsonList);
    await securePrefs!.setCategories(categoriesJson);
  }

  Future<T?> loadModelFromStorage<T>({
    required String userId,
    required Future<String?> Function(String userId) getter,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    if (securePrefs == null) {
      throw Exception('SecurePrefs is not initialized');
    }

    final jsonString = await getter(userId);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return fromJson(jsonMap);
  }

  Future<void> saveModelToStorage<T>({
    required String userId,
    required T model,
    required Future<void> Function(String userId, String json) setter,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    if (securePrefs == null) {
      throw Exception('SecurePrefs is not initialized');
    }

    final jsonMap = toJson(model);
    final jsonString = json.encode(jsonMap);
    await setter(userId, jsonString);
  }

  Future<void> updateModelField<T>({
    required String userId,
    required Future<T> Function(String userId) getter,
    required Future<void> Function(T model) saver,
    required T Function(T model) updater,
  }) async {
    if (securePrefs == null) {
      throw Exception('SecurePrefs is not initialized');
    }

    final currentModel = await getter(userId);
    final updatedModel = updater(currentModel);
    await saver(updatedModel);
  }

  Future<void> clearAllStorage() async {
    if (securePrefs == null) {
      throw Exception('SecurePrefs is not initialized');
    }

    await securePrefs!.clearAll();
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<bool> verifyPasswordHash(String password, String storedHash) async {
    final inputHash = hashPassword(password);
    return inputHash == storedHash;
  }

  Future<void> changePasswordWithVerification({
    required String oldPassword,
    required String newPassword,
    required Future<String?> Function() getStoredHash,
    required Future<void> Function(String hash) setNewHash,
  }) async {
    final storedHash = await getStoredHash();

    if (storedHash == null) {
      throw AuthenticationException('No password set');
    }

    final isValid = await verifyPasswordHash(oldPassword, storedHash);
    if (!isValid) {
      throw AuthenticationException('Incorrect old password');
    }

    final newPasswordHash = hashPassword(newPassword);
    await setNewHash(newPasswordHash);
  }

  Future<String> exportTransactionsToCSV({
    required List<TransactionDataModel> transactions,
    required String filePrefix,
  }) async {
    if (transactions.isEmpty) {
      throw ExportException('No transactions to export');
    }

    final List<List<dynamic>> rows = [
      ['Date', 'Type', 'Category', 'Description', 'Amount'],
    ];

    for (final transaction in transactions) {
      final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
      rows.add([
        dateFormat.format(transaction.date),
        transaction.type,
        transaction.category.name,
        transaction.description,
        transaction.amount.toStringAsFixed(2),
      ]);
    }

    final csvData = const ListToCsvConverter().convert(rows);
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final filePath = '${directory.path}/${filePrefix}_$timestamp.csv';
    final file = File(filePath);
    await file.writeAsString(csvData);

    return filePath;
  }

  Future<String> exportTransactionsToPDF({
    required List<TransactionDataModel> transactions,
    required String filePrefix,
  }) async {
    if (transactions.isEmpty) {
      throw ExportException('No transactions to export');
    }

    final pdf = pw.Document();
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    final summary = calculateFinancialSummary(transactions);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                'Transactions Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Generated: ${dateFormat.format(DateTime.now())}',
              style: const pw.TextStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 20),
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Summary',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Total Income: \$${summary.totalIncome.toStringAsFixed(2)}',
                  ),
                  pw.Text(
                    'Total Expenses: \$${summary.totalExpenses.toStringAsFixed(2)}',
                  ),
                  pw.Text(
                    'Balance: \$${summary.totalBalance.toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ['Date', 'Type', 'Category', 'Description', 'Amount'],
              data: transactions.map((transaction) {
                return [
                  dateFormat.format(transaction.date),
                  transaction.type,
                  transaction.category.name,
                  transaction.description,
                  '\$${transaction.amount.toStringAsFixed(2)}',
                ];
              }).toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellAlignment: pw.Alignment.centerLeft,
            ),
          ];
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final filePath = '${directory.path}/${filePrefix}_$timestamp.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    return filePath;
  }

  FinancialSummaryDataModel calculateFinancialSummary(
    List<TransactionDataModel> transactions,
  ) {
    double totalBalance = 0.0;
    double totalIncome = 0.0;
    double totalExpenses = 0.0;

    for (final transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
        totalBalance += transaction.amount;
      } else if (transaction.type == 'expense') {
        totalExpenses += transaction.amount;
        totalBalance -= transaction.amount;
      }
    }

    return FinancialSummaryDataModel(
      totalBalance: totalBalance,
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
    );
  }

  List<TransactionDataModel> filterTransactionsByPeriod(
    List<TransactionDataModel> transactions,
    String period,
  ) {
    final now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case 'day':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case 'week':
        startDate = now.subtract(Duration(days: now.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        break;
      case 'month':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case 'year':
        startDate = DateTime(now.year, 1, 1);
        break;
      default:
        startDate = DateTime(now.year, now.month, 1);
    }

    return transactions
        .where(
          (t) =>
              t.date.isAfter(startDate) || t.date.isAtSameMomentAs(startDate),
        )
        .toList();
  }
}
