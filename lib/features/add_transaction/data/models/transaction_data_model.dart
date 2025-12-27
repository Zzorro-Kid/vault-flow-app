import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/features/add_transaction/data/models/transaction_data.dart';

class TransactionDataModel extends TransactionData {
  const TransactionDataModel({
    required super.id,
    required super.amount,
    required super.category,
    required super.description,
    required super.date,
    required super.type,
  });

  factory TransactionDataModel.fromJson(Map<String, dynamic> json) {
    return TransactionDataModel(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: CategoryDataModel.fromJson(
        json['category'] as Map<String, dynamic>,
      ),
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': (category as CategoryDataModel).toJson(),
      'description': description,
      'date': date.toIso8601String(),
      'type': type,
    };
  }

  TransactionDataModel copyWith({
    String? id,
    double? amount,
    CategoryDataModel? category,
    String? description,
    DateTime? date,
    String? type,
  }) {
    return TransactionDataModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }
}
