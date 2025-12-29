import 'package:equatable/equatable.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';

class CategoryBreakdownData extends Equatable {
  final CategoryData category;
  final double amount;
  final double percentage;
  final int transactionCount;

  const CategoryBreakdownData({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.transactionCount,
  });

  @override
  List<Object?> get props => [category, amount, percentage, transactionCount];
}
