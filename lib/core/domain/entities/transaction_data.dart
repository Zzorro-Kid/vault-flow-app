import 'package:equatable/equatable.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';

class TransactionData extends Equatable {
  final String id;
  final double amount;
  final CategoryData category;
  final String description;
  final DateTime date;
  final String type;

  const TransactionData({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
    required this.type,
  });

  @override
  List<Object?> get props => [id, amount, category, description, date, type];
}
