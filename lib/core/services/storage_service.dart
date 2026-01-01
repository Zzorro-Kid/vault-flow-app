import 'dart:convert';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/core/secure_prefs.dart';

/// Service responsible for all storage operations with SecurePrefs
class StorageService {
  final SecurePrefs securePrefs;

  const StorageService({required this.securePrefs});

  /// Loads all transactions from secure storage
  Future<List<TransactionDataModel>> loadTransactions() async {
    final transactionsJson = await securePrefs.transactions;

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

  /// Saves all transactions to secure storage
  Future<void> saveTransactions(List<TransactionDataModel> transactions) async {
    final jsonList = transactions.map((t) => t.toJson()).toList();
    final transactionsJson = json.encode(jsonList);
    await securePrefs.setTransactions(transactionsJson);
  }

  /// Loads all categories from secure storage
  Future<List<CategoryDataModel>> loadCategories() async {
    final categoriesJson = await securePrefs.categories;

    if (categoriesJson == null || categoriesJson.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = json.decode(categoriesJson) as List<dynamic>;

    return jsonList
        .map((json) => CategoryDataModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Saves all categories to secure storage
  Future<void> saveCategories(List<CategoryDataModel> categories) async {
    final jsonList = categories.map((c) => c.toJson()).toList();
    final categoriesJson = json.encode(jsonList);
    await securePrefs.setCategories(categoriesJson);
  }

  /// Generic method to load a model from storage
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

  /// Generic method to save a model to storage
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

  /// Updates a specific field in a model
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

  /// Clears all data from secure storage
  Future<void> clearAll() async {
    await securePrefs.clearAll();
  }
}
