import 'dart:convert';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/core/secure_prefs.dart';

class StorageService {
  final SecurePrefs securePrefs;

  List<TransactionDataModel>? _cachedTransactions;
  List<CategoryDataModel>? _cachedCategories;

  StorageService({required this.securePrefs});

  Future<List<TransactionDataModel>> loadTransactions({
    int offset = 0,
    int limit = 50,
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    String? type,
  }) async {
    final allTransactions = await _loadAllTransactions();

    var filteredTransactions = allTransactions;

    if (startDate != null) {
      filteredTransactions = filteredTransactions
          .where(
            (t) =>
                t.date.isAfter(startDate) || t.date.isAtSameMomentAs(startDate),
          )
          .toList();
    }

    if (endDate != null) {
      filteredTransactions = filteredTransactions
          .where(
            (t) => t.date.isBefore(endDate) || t.date.isAtSameMomentAs(endDate),
          )
          .toList();
    }

    if (categoryId != null) {
      filteredTransactions = filteredTransactions
          .where((t) => (t.category as dynamic).id == categoryId)
          .toList();
    }

    if (type != null) {
      filteredTransactions = filteredTransactions
          .where((t) => t.type == type)
          .toList();
    }

    filteredTransactions.sort((a, b) => b.date.compareTo(a.date));

    final end = (offset + limit).clamp(0, filteredTransactions.length);
    final start = offset.clamp(0, end);

    return filteredTransactions.sublist(start, end);
  }

  Future<List<TransactionDataModel>> _loadAllTransactions() async {
    if (_cachedTransactions != null) {
      return _cachedTransactions!;
    }

    final transactionsJson = await securePrefs.transactions;

    if (transactionsJson == null || transactionsJson.isEmpty) {
      _cachedTransactions = [];
      return _cachedTransactions!;
    }

    final List<dynamic> jsonList =
        json.decode(transactionsJson) as List<dynamic>;

    _cachedTransactions = jsonList
        .map(
          (json) => TransactionDataModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
    return _cachedTransactions!;
  }

  Future<void> saveTransactions(List<TransactionDataModel> transactions) async {
    _cachedTransactions = transactions;
    final jsonList = transactions.map((t) => t.toJson()).toList();
    final transactionsJson = json.encode(jsonList);
    await securePrefs.setTransactions(transactionsJson);
  }

  Future<List<CategoryDataModel>> loadCategories({
    int offset = 0,
    int limit = 50,
    String? type,
  }) async {
    final allCategories = await _loadAllCategories();

    var filteredCategories = allCategories;

    if (type != null) {
      filteredCategories = filteredCategories
          .where((c) => c.type == type)
          .toList();
    }

    final end = (offset + limit).clamp(0, filteredCategories.length);
    final start = offset.clamp(0, end);

    return filteredCategories.sublist(start, end);
  }

  Future<List<CategoryDataModel>> _loadAllCategories() async {
    if (_cachedCategories != null) {
      return _cachedCategories!;
    }

    final categoriesJson = await securePrefs.categories;

    if (categoriesJson == null || categoriesJson.isEmpty) {
      _cachedCategories = [];
      return _cachedCategories!;
    }

    final List<dynamic> jsonList = json.decode(categoriesJson) as List<dynamic>;

    _cachedCategories = jsonList
        .map((json) => CategoryDataModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return _cachedCategories!;
  }

  Future<void> saveCategories(List<CategoryDataModel> categories) async {
    _cachedCategories = categories;
    final jsonList = categories.map((c) => c.toJson()).toList();
    final categoriesJson = json.encode(jsonList);
    await securePrefs.setCategories(categoriesJson);
  }

  Future<T?> loadModel<T>({
    required String userId,
    required Future<String?> Function(String userId) getter,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final jsonString = await getter(userId);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return fromJson(jsonMap);
  }

  Future<void> saveModel<T>({
    required String userId,
    required T model,
    required Future<void> Function(String userId, String json) setter,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
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
    final currentModel = await getter(userId);
    final updatedModel = updater(currentModel);
    await saver(updatedModel);
  }

  Future<void> clearAll() async {
    _cachedTransactions = null;
    _cachedCategories = null;
    await securePrefs.clearAll();
  }

  void invalidateTransactionsCache() {
    _cachedTransactions = null;
  }

  void invalidateCategoriesCache() {
    _cachedCategories = null;
  }

  void invalidateAllCaches() {
    _cachedTransactions = null;
    _cachedCategories = null;
  }
}
