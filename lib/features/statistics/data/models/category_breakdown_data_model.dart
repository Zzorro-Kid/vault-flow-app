import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/features/statistics/domain/entities/category_breakdown_data.dart';

class CategoryBreakdownDataModel extends CategoryBreakdownData {
  const CategoryBreakdownDataModel({
    required super.category,
    required super.amount,
    required super.percentage,
    required super.transactionCount,
  });

  factory CategoryBreakdownDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryBreakdownDataModel(
      category: CategoryDataModel.fromJson(
        json['category'] as Map<String, dynamic>,
      ),
      amount: (json['amount'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
      transactionCount: json['transactionCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': (category as CategoryDataModel).toJson(),
      'amount': amount,
      'percentage': percentage,
      'transactionCount': transactionCount,
    };
  }

  factory CategoryBreakdownDataModel.fromEntity(CategoryBreakdownData entity) {
    return CategoryBreakdownDataModel(
      category: CategoryDataModel.fromEntity(entity.category),
      amount: entity.amount,
      percentage: entity.percentage,
      transactionCount: entity.transactionCount,
    );
  }
}
