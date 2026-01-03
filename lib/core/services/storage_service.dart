import 'dart:convert';
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/core/secure_prefs.dart';

class StorageService {
  final SecurePrefs securePrefs;

  const StorageService({required this.securePrefs});

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

  Future<void> saveTransactions(List<TransactionDataModel> transactions) async {
    final jsonList = transactions.map((t) => t.toJson()).toList();
    final transactionsJson = json.encode(jsonList);
    await securePrefs.setTransactions(transactionsJson);
  }

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

  Future<void> saveCategories(List<CategoryDataModel> categories) async {
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
    await securePrefs.clearAll();
  }
}
